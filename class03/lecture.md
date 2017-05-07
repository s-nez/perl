# Warsztat 03

<!--TOC_START--->
## Spis treści
* [Funkcje](#funkcje)
    * [Deklaracja](#deklaracja)
    * [Wywołanie](#wywołanie)
    * [Obsługa argumentów](#obsługa-argumentów)
        * [Kontrola liczby argumentów](#kontrola-liczby-argumentów)
        * [Argumenty domyślne](#argumenty-domyślne)
        * [Argumenty nazwane](#argumenty-nazwane)
        * [Modyfikacja argumentów](#modyfikacja-argumentów)
    * [Zwracanie wartości](#zwracanie-wartości)
* [Moduły](#moduły)
    * [Exporter](#exporter)
* [CPAN](#cpan)
* [Operacje na plikach](#operacje-na-plikach)
    * [Uchwyty](#uchwyty)
    * [Odczytywanie plików](#odczytywanie-plików)
    * [Zapisywanie plików](#zapisywanie-plików)
        * [Dopisywanie danych do pliku](#dopisywanie-danych-do-pliku)
        * [Domyślny uchwyt wyjściowy](#domyślny-uchwyt-wyjściowy)
    * [Wczytywanie i zapisywanie tego samego pliku](#wczytywanie-i-zapisywanie-tego-samego-pliku)
    * [Wymiana danych pomiędzy programami (pipes)](#wymiana-danych-pomiędzy-programami-pipes)
        * [Wczytywanie danych z innego programu](#wczytywanie-danych-z-innego-programu)
        * [Wysyłanie danych do innego programu](#wysyłanie-danych-do-innego-programu)
    * [Właściwości plików](#właściwości-plików)
    * [Zmiana nazwy i kopiowanie plików](#zmiana-nazwy-i-kopiowanie-plików)
    * [Przeszukiwanie katalogów](#przeszukiwanie-katalogów)
    * [Tworzenie i usuwanie katalogów](#tworzenie-i-usuwanie-katalogów)

<!--TOC_END--->

## Funkcje
### Deklaracja
Do deklaracji funkcji służy słowo kluczowe **sub**:
```perl
sub foo { ... }
```
Funkcję można też zadeklarować bez podawania bezpośrednio jej kodu, żeby
poinformować program, że taka funkcja istnieje.
```perl
sub foo;
```

### Wywołanie
Klasycznie, funkcję wywołuje się operatorem **()**:
```perl
foo(7, 12, 'text');
foo();
```

Argumentem funkcji zawsze jest lista, więc wszystkie zmienne i wyrażenia
podawane jako argumenty będą interpretowane w kontekście listowym.
```perl
foo($scalar); # jednoelementowa lista
foo(@array);  # lista elementów tablicy
foo(%hash);   # lista par klucz-wartość hasza
```

### Obsługa argumentów
Argumenty funkcji przechowywane są w specjalnej tablicy **@_**, wewnątrz
funkcji jest to domyślna zmienna tablicowa.
```perl
sub print_first_arg {
    my $first = shift;
    print $first;
}

sub print_all_args {
    print "@_";
}
```

Do argumentów można odwoływać się bezpośrednio przez tablicę **@_**, więc
**$\_[0]** to pierwszy argument, **$\_[1]** to drugi, itd. Dla czytelności
zaleca się jednak rozpakowywać argumenty na początku funkcji:
```perl
sub print_x_times {
    my ($text, $times) = @_;
    print $text x $times;
}
```

Tablica argumentów zachowuje się jak normalna tablica, możemy na niej
wykonywać wszystkie typowe operacje (shift, unshift, push, pop, itd.).

#### Kontrola liczby argumentów
Funkcje przyjmują nieokreśloną liczbę argumentów, jeśli potrzebujemy
konkretnej ilości argumentów do prawidłowego działania funkcji, możemy
wyrzucić błąd wewnątrz funkcji:
```perl
sub need_three_args {
    die 'Insufficient number of arguments' unless @_ == 3;
    ...
}
```

#### Argumenty domyślne
Jeśli podczas rozpakowania argumentów okaże się, że któryś nie został podany,
pozostanie niezdefiniowany. Dzięki temu, możemy w prosty sposób przypisać
domyślne argumenty operatorem **//**:
```perl
sub repeat_prefixed {
    my ($text, $prefix, $reps) = @_;
    $prefix //= '>';
    $reps   //= 1;
    ...
}
```

#### Argumenty nazwane
Przy dużej ilości argumentów, z których większość jest opcjonalna i ma
domyślne wartości, warto rozważyć użycie nazwanych argumentów.
```perl
sub do_stuff {
    my %arg = @_;
    $arg{length}   //= 10;
    $arg{repeat}   //= 1;
    $arg{some_arg} //= 'arg';
    ...
}
```
Przypisanie listy argumentów do hasza pozwala nam na wywołanie funkcji
w następujący sposób:
```perl
do_stuff(length => 12, repeat => 0);
do_stuff();
do_stuff(some_arg => 'hue', length => 5);
```

#### Modyfikacja argumentów
Tablica **@_** zawiera aliasy przekazanych argumentów, to znaczy, że jeśli
będziemy zmieniać jej elementy, przekazane zmienne również ulegną zmianie:
```perl
sub double_arg {
    $_[0] *= 2;
}

my $num = 2;
double_arg($num);
$num; # 4
```

### Zwracanie wartości
Użycie instrukcji **return** powoduje zakończenie działania funkcji i zwrócenie
jej argumentu:
```perl
sub is_even {
    my $number = shift;
    return $number % 2 == 0 ? 1 : 0;
}

is_even(4); # 1
is_even(3); # 0
```

Jeśli funkcja zakończyła działanie bez wykonania **return**, zwrócona
zostaje ostatnia wartość, która pojawiła się w funkcji. Poniższa funkcja
zwróci losową liczbę całkowitą z podanego przedziału:
```perl
sub random_range {
    my ($start, $end) = @_;
    int rand($end - $start) + $start;
}
```

**UWAGA:** Nie powinno się używać tego zachowania w nazwanych funkcjach,
dużo lepiej jest jawnie zwrócić wartość przez **return**.

Jeśli nasza funkcja jest procedurą, tj. nie zwraca żadnej wartości, powinna
kończyć się **return** bez argumentów, żeby uniknąć zwracania ostatniej
wartości.
```perl
sub prepend_id {
    my $id = shift;
    foreach my $entry (@_) {
        $entry = $id . ':' . $entry;
    }
    return;
}

my @entries = qw(word two test); # ('word', 'two', 'test')
prepend_id(42, @entries);
@entries; # ('42:word', '42:two', '42:test')
```

## Moduły
Funkcje można grupować w modułach dla lepszego uporządkowania kodu lub
umożliwienia łatwego korzystania z nich w nowych programach. 

Moduły Perla mają rozszerzenie .pm i następującą postać:
```perl
package Modname;

sub foo { ... }
sub bar { ... }
```

Aby użyć modułu w programie, na początku należy dodać:
```perl
use Modname;
```

Funkcje zdefiniowane w module można wywoływać poprzedzając je nazwą modułu:
```perl
Modname::foo();
Modname::bar();
```

### Exporter
Funkcje zdefiniowane w modułach można eksportować do innych przestrzeni nazw,
służy do tego wbudowany moduł Exporter. Jeśli używamy funkcji 'import'
Exportera, możliwe jest zdefiniowanie listy funkcji, które mają
być dostępne w miejscu, w którym używamy naszego modułu.

```perl
package Modname;
use Exporter 'import';
our @EXPORT = qw(foo bar);

sub foo { ... }
sub bar { ... }
sub helper { ... }
```

Teraz w programie używającym modułu **Modname** dostępne będą funkce **foo** i
**bar**, ale nie **helper**, ponieważ nie ma jej w tablicy @EXPORT.

Więcj informacji można znaleźć w dokumentacji Exportera (``perldoc Exporter``).

## CPAN
W repozytorium [CPAN](http://www.cpan.org/) (Comprehensive Perl Archive
Network) znajdują się wszelkiego rodzaju moduły do Perla, zarówno te będące
częścią domyślnej dystrybucji, jak i dodatkowe.

Liczba dostępnych modułów jest naprawdę duża i dla wielu problemów, z którymi
możemy się spotkać podczas programowania, istnieje spora szansa, że rozwiązanie
jest już na CPANie.

Moduły można pobierać bezpośrednio lub używać klientów. Wiele popularnych
modułów można też znaleźć w repozytoriach pakietów dystrybucji GNU.
Przykładowo, w repozytoriach [Fedory](https://getfedora.org/) jest ponad
3000 modułów.

Narzędzie **cpan** i moduł **CPAN** powinny być dostępne z każdą instalacją
Perla. Aby zainstalować nowy moduł, należy podać go jako argument **cpan**:
```
$ cpan Image::ExifTool
```

Większość modułów z CPAN dostarcza dokumentację. Po zainstalowaniu modułu
powinna być dostępna strona **perldoc** odpowiadająca jego nazwie:
```
$ perldoc Image::ExifTool
```

## Operacje na plikach
### Uchwyty
Zanim zaczniemy pracę z plikiem, należy go otworzyć. Załóżmy, że chcemy
odczytać plik o nazwie "plik.md":
```perl
open my $fh, '<', 'plik.md';
```
Funkcja **open** przyjmuje trzy argumenty:
* zmienną, która będzie uchwytem do pliku
* tryb operacji na pliku
* nazwę pliku

**UWAGA**: Otwarcie pliku może się nie powieść (plik nie istnieje, nie mamy do
niego dostępu, itp.), **open** zwraca fałsz i ustawia specjalną zmienną **$!**,
zawierającą ostatni błąd, jeśli otwarcie pliku się nie powiedzie. Pozwala to na
wykrycie błędu otwierania pliku w następujący sposób:
```perl
open my $fh, '<', 'plik.md' or die $!;
```
Funkcja **die** przyjmuje komunikat o błędzie jako argument i kończy działanie
programu informując użytkownika o błędzie.

Po zakończeniu pracy z plikiem należy zamknąć uchwyt:
```perl
close $fh;
```

### Odczytywanie plików
Czytanie plików odbywa się tak samo jak czytanie ze standardowego wejścia,
**STDIN** wystarczy zastąpić uchwytem do pliku, z którego dane chcemy wczytać.
```perl
open my $fh, '<', 'plik.in' or die $!;
while (<$fh>) {
    print;
}
close $fh;
```

### Zapisywanie plików
Otwarcie pliku w trybie **>** zeruje plik (usuwa całą jego zawartość) i
pozwala na zapis danych. Analogicznie do odczytu, zapis nie różni się zbytnio
od operacji wypisywania danych na standardowe wyjście.
```perl
open my $fh, '>', 'plik.out' or die $!;
foreach my $data ('some data', 'some other data', 'more data') {
    say $fh "OUT: $data"; }
close $fh;
```
Funkcje **print** i **say** mogą przyjąć uchwyt do pliku jako modyfikator przed
listą argumentów. Ich zachowanie jest dokładnie takie samo jak w przypadku
wypisywania na standardowe wyjście, jedyną różnicą jest fakt, że wyjście trafia
do wybranego pliku.

**UWAGA**: Modyfikator uchwytu do pliku dla **say** i **print** nie jest
typowym argumentem funkcji, więc nie powinno po nim być przecinka.

#### Dopisywanie danych do pliku
Żeby dopisać dane do pliku, bez zerowania go, można użyć trybu **>>**.

#### Domyślny uchwyt wyjściowy
Jeśli nie podamy funkcji **print** lub **say** uchwytu do pliku jako
modyfikatora, wypiszą dane do domyślnego uchwytu wyjściowego. Zazwyczaj jest to
**STDOUT**, ale istnieje możliwość wyboru innego uchwytu za pomocą funkcji
**select**.
```perl
open my $fh, '>', 'plik.out' or die $!;
say 'Standard';
say $fh 'Explicit file'
select $fh;
say 'File';
say STDOUT 'Explicit standard';
close $fh;
```
W wyniku działania tego programu na standardowe wyjście zostanie wypisane:
```
Standard
Explicit standard
```
a do pliku _plik.out_:
```
Explicit file
File
```

### Wczytywanie i zapisywanie tego samego pliku
Dodanie znaku **+** do trybów wczytywania i zapisywania pliku (**<** i **>**)
otworzy plik w trybie do zapisu i odczytu.
```perl
open my $fh, '+<', 'plik.io' or die $!;
```
Teraz na uchwycie **$fh** działa zarówno **print**, jak i **readline**.
Tryb **+>** dodatkowo wyzeruje plik.


### Wymiana danych pomiędzy programami (pipes)
Na danych z innego programu możemy operować w identyczny sposób jak na plikach.

#### Wczytywanie danych z innego programu
Do wczytania danych z innego programu można użyć trybu **-|**. Zamiast nazwy
pliku należy wtedy podać nazwę programu, z którego chcemy wczytać dane, oraz
jego argumenty.
```perl
open my $LOGS, '-|', qw( journalctl -u tor.service -f ) or die $!;
while (<$LOGS>) {
    ...;
}
```
Powyższy kod pozwala nam wczytywać na bieżąco logi usługi
[TOR](https://www.torproject.org/).

#### Wysyłanie danych do innego programu
Analogicznie, używając trybu **|-**, możemy wysyłać dane do innego programu,
wszystkie opracje działają dokładnie tak samo jak w przypadku zapisu pliku.

### Właściwości plików
Perl dostarcza wielu operatorów pozwalających sprawdzać właściwości plików.
Wszystkie te operatory przyjmują nazwę pliku jako argument. Kilka z bardziej
przydatnych:
- **-e** czy plik istnieje
- **-s** rozmiar pliku
- **-M** czas od ostatniej modyfikacji pliku
- **-A** czas od ostatniego dostępu do pliku
- **-d** plik jest katalogiem

Pełna lista:
```
perldoc -f -X
```

Następujący program będzie wczytywał wejście aż użytkownik nie poda nazwy
istniejącego pliku:
```perl
my $filename;
do {
    $filename = <>;
    chomp $filename;
} until (-e $filename);
```

### Zmiana nazwy i kopiowanie plików
Funkcja **rename** pozwala na zmienę nazwy lub przeniesienie pliku. Następujący
kod zmieni nazwę pliku *old\_name* na *new\_name*.
```perl
rename 'old_name', 'new_name';
```
Możemy też użyć **=>** zamiast przecinka:
```perl
rename 'old_name' => 'new_name';
```

Do kopiowania plików potrzebny jest moduł
[File::Copy](https://metacpan.org/pod/File::Copy), jest to domyślny moduł
Perla, więc nie trzeba niczego doinstalowywać. Dostarcza on m. in. funkcje
**copy** i **move**. Pierwszej z nich możemy użyć do skopiowania pliku:
```perl
use File::Copy;
copy 'some_file', 'copy_of_some_file';
```

### Przeszukiwanie katalogów
Funkcja **opendir** pozwala otworzyć uchwyt do folderu. Wykonanie **readdir**
na takim uchwycie pozwala wczytywać po kolei nazwy plików znajdujących się
w folderze.
```perl
opendir my $DIR, '.' or die $!;
say while readdir $DIR;
closedir $DIR;
```
Powyższy przykład wyświetla listę plików w aktualnym folderze.

### Tworzenie i usuwanie katalogów
Perl dostarcza funkcję o znajomej nazwie **mkdir** do tworzenia katalogów.
```perl
mkdir 'new_directory';
```
Powyższy kod stworzy w aktualnym katalogu nowy o nazwie *new_directory*.

Analogicznie, funkcja **rmdir** pozwala usunąć puste katalogi.

**UWAGA**: **mkdir** jest w stanie stworzyć tylko pojedynczy katalog.
Jeśli potrzebujemy utworzyć całą ścieżkę, np. "one/two/three", należy
użyć funkcji **make\_path** z wbudowanego modułu
[File::Path](https://metacpan.org/pod/File::Path):
```perl
use File::Path qw[ make_path ];
make_path("one/two/three");
```
