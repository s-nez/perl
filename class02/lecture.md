# Warsztat 02

<!--TOC_START--->
## Spis treści
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

## Operacje na plikach
### Uchwyty
Zanim zaczniemy pracę z plikiem, należy go otworzyć. Załóżmy, że chcemy
odczytać plik o nazwie "plik.md":
````perl
open my $FH, '<', 'plik.md';
````
Funkcja **open** przyjmuje trzy argumenty:
* zmienną, która będzie uchwytem do pliku
* tryb operacji na pliku
* nazwę pliku

**UWAGA**: Otwarcie pliku może się nie powieść (plik nie istnieje, nie mamy do
niego dostępu, itp.), **open** zwraca fałsz i ustawia specjalną zmienną **$!**,
zawierającą ostatni błąd, jeśli otwarcie pliku się nie powiedzie. Pozwala to na
wykrycie błędu otwierania pliku w następujący sposób:
````perl
open my $FH, '<', 'plik.md' or die $!;
````
Funkcja **die** przyjmuje komunikat o błędzie jako argument i kończy działanie
programu informując użytkownika o błędzie.

Po zakończeniu pracy z plikiem należy zamknąć uchwyt:
````perl
close $FH;
````

### Odczytywanie plików
Czytanie plików odbywa się tak samo jak czytanie ze standardowego wejścia,
**STDIN** wystarczy zastąpić uchwytem do pliku, z którego dane chcemy wczytać.
````perl
open my $FH, '<', 'plik.in' or die $!;
while (<$FH>) {
    print;
}
close $FH;
````

### Zapisywanie plików
Otwarcie pliku w trybie **>** zeruje plik (usuwa całą jego zawartość) i
pozwala na zapis danych. Analogicznie do odczytu, zapis nie różni się zbytnio
od operacji wypisywania danych na standardowe wyjście.
````perl
open my $FH, '>', 'plik.out' or die $!;
foreach my $data ('some data', 'some other data', 'more data') {
    say $FH "OUT: $data";
}
close $FH;
````
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
````perl
open my $FH, '>', 'plik.out' or die $!;
say 'Standard';
say $FH 'Explicit file'
select $FH;
say 'File';
say STDOUT 'Explicit standard';
close $FH;
````
W wyniku działania tego programu na standardowe wyjście zostanie wypisane:
````
Standard
Explicit standard
````
a do pliku _plik.out_:
````
Explicit file
File
````

### Wczytywanie i zapisywanie tego samego pliku
Dodanie znaku **+** do trybów wczytywania i zapisywania pliku (**<** i **>**)
otworzy plik w trybie do zapisu i odczytu.
````perl
open my $FH, '+<', 'plik.io' or die $!;
````
Teraz na uchwycie **$FH** działa zarówno **print**, jak i **readline**.
Tryb **+>** dodatkowo wyzeruje plik.


### Wymiana danych pomiędzy programami (pipes)
Na danych z innego programu możemy operować w identyczny sposób jak na plikach.

#### Wczytywanie danych z innego programu
Do wczytania danych z innego programu można użyć trybu **-|**. Zamiast nazwy
pliku należy wtedy podać nazwę programu, z którego chcemy wczytać dane, oraz
jego argumenty.
````perl
open my $LOGS, '-|', qw( journalctl -u tor.service -f ) or die $!;
while (<$LOGS>) {
    ...;
}
````
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
````
perldoc -f -X
````

Następujący program będzie wczytywał wejście aż użytkownik nie poda nazwy
istniejącego pliku:
````perl
my $filename;
do {
    $filename = <>;
    chomp $filename;
} until (-e $filename);
````

### Zmiana nazwy i kopiowanie plików
Funkcja **rename** pozwala na zmienę nazwy lub przeniesienie pliku. Następujący kod
zmieni nazwę pliku _old\_name_ na _new\_name_.
````perl
rename 'old_name', 'new_name';
````
Jeśli chcemy przyszpanować stylem, możemy użyć **=>** zamiast przecinka:
````perl
rename 'old_name' => 'new_name';
````

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
````perl
opendir my $DIR, '.' or die $!;
say while readdir $DIR;
close $DIR;
````
Powyższy przykład wyświetla listę plików w aktualnym folderze.

### Tworzenie i usuwanie katalogów
Perl dostarcza funkcję o znajomej nazwie **mkdir** do tworzenia katalogów.
````perl
mkdir 'new_directory';
````
Powyższy kod stworzy w aktualnym katalogu nowy o nazwie _new\_directory_.

Analogicznie, funkcja **rmdir** pozwala usunąć puste katalogi.
