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
* [Przydatne funkcje wbudowane](#przydatne-funkcje-wbudowane)
    * [sort](#sort)
    * [map](#map)
    * [grep](#grep)
    * [Łączenie wywołań](#Łączenie-wywołań)
* [Zagnieżdżone struktury danych](#zagnieżdżone-struktury-danych)
    * [Referencje](#referencje)
        * [Anonimowe zmienne](#anonimowe-zmienne)
    * [Wielowymiarowe tablice](#wielowymiarowe-tablice)
    * [Inne rodzaje zagnieżdżonych struktur danych](#inne-rodzaje-zagnieżdżonych-struktur-danych)
    * [Autovivification](#autovivification)
    * [Data::Dumper](#datadumper)
* [Transformata Schwartza](#transformata-schwartza)

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

Najprostszy moduł Perla ma rozszerzenie .pm i następującą postać:
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
Network) znajdują się wszelkiego rodzaju moduły do Perla, zarówno główne,
będące częścią domyślnej dystrybucji, jak i dodatkowe.

Ilość dostępnych modułów jest naprawdę duża i dla wielu problemów, z którymi
możemy się spotkać podczas programowania, jest spora szansa, że rozwiązanie
jest już na CPANie.

Moduły można pobierać bezpośrednio lub używać klientów. Wiele popularnych
modułów można też znaleźć w repozytoriach pakietów dystrybucji GNU.
Przykładowo, w repozytoriach Fedory jest ponad 3000 modułów.

### Konfiguracja CPAN

Narzędzie **cpan** i moduł **CPAN** powinny być dostępne z każdą instalacją
Perla. Przy pierwszym uruchomieniu uruchaia się konfigurator.
