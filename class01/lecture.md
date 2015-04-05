# Warsztat 01

<!--TOC_START--->
## Spis treści
* [Instalacja](#instalacja)
    * [Edytor](#edytor)
* [Hello World! i uruchamianie programów](#hello-world-i-uruchamianie-programów)
* [Perldoc](#perldoc)
    * [Jak używać dokumentacji](#jak-używać-dokumentacji)
    * [Przydatne strony dokumentacji](#przydatne-strony-dokumentacji)
* [Zmienne](#zmienne)
    * [Skalary](#skalary)
        * [Deklaracja z inicjalizacją](#deklaracja-z-inicjalizacją)
        * [Liczby](#liczby)
        * [Napisy](#napisy)
    * [Tablice](#tablice)
        * [Deklaracja z inicjalizacją ](#deklaracja-z-inicjalizacją-)
        * [Dostęp do elementów](#dostęp-do-elementów)
        * [Pojemność tablicy](#pojemność-tablicy)
        * [Operacje na tablicach](#operacje-na-tablicach)
        * [Podtablice](#podtablice)
        * [Kontekst](#kontekst)
* [Logika](#logika)
    * [Podstawowe instrukcje warunkowe](#podstawowe-instrukcje-warunkowe)
    * [Operator ternarny](#operator-ternarny)
    * [Operatory logiczne](#operatory-logiczne)
        * [Operatory z kontekstem logicznym](#operatory-z-kontekstem-logicznym)
        * [Operatory z kontekstem numerycznym](#operatory-z-kontekstem-numerycznym)
        * [Operatory z kontekstem napisowym](#operatory-z-kontekstem-napisowym)
    * [Kontekst logiczny](#kontekst-logiczny)
        * [Liczby](#liczby)
        * [Napisy](#napisy)
        * [Undef](#undef)
        * [Tablice, listy i hashe](#tablice-listy-i-hashe)

<!--TOC_END--->

## Instalacja
Perl jest zainstalowy domyślnie w większości dystrybucji GNU. Instalacja
pakietu _perl_ powinna wystarczyć do normalnej pracy.

Jeśli ktoś jest zmuszony do używania Windowsa, to
[Strawberry Perl](http://strawberryperl.com/) wydaje się najlepszą
opcją.

### Edytor
Najprostszy edytor tekstu i terminal wystarczą do pisania i uruchamiania
programów. [Geany](http://www.geany.org/) jest dobrym wyborem na początek.

## Hello World! i uruchamianie programów
Tradycyjny program Hello World! w Perlu:
````perl
#!/usr/bin/perl
print "Hello World!\n";
````
Jedyne, czego potrzebujemy, to charakterystyczny dla języków skryptowych
shebang i instrukcja _print_, której nazwa mówi sama za siebie.

Zakładając, że program został zapisany w pliku _hello.pl_, możemy go
uruchomić poleceniem:
````
perl hello.pl
````
lub, jeśli nadamy mu prawa do wykonywania:
````
./hello.pl
````

## Perldoc
Każda instalacja Perla jest wyposażona w narzędzie _perldoc_. Pozwala
ono czytać dokumentację każdego aktualnie zainstalowaneg modułu,
wbudowanych funkcji i specjalnych zmiennych. Dokumentacja języka
zawiera też szczegółowe instrukcje obsługi i objaśnienia różnych części
języka, jak również wprowadzenia dla początkujących. Dobra dokumentacja
jest częścią kultury Perla.

### Jak używać dokumentacji
Dokumentacja języka:
````
perldoc perltoc
perldoc perlrun
perldoc perlreftut
````
Pierwsze polecenie wyświetli spis treści z krótkimi opisami głównej
dokumentacji języka. Drugie, informacje o parametrach wywołania
interpretera, a trzecie, wprowadzenie do referencji.

Dokumentacja konkretnego modułu:
````
perldoc Data::Dumper
perldoc Reddit::Client
````
Dokumentacja wbudowanych funkcji:
````
perldoc -f sort
perldoc -f push
````
Opisy specjalnych zmiennych:
````
perldoc -v '$_'
perldoc -v '$.'
perldoc -v '@ARGV'
````
**UWAGA:** Wiele powłok używa $ do oznaczania swoich zmiennych, dlatego
dobrym zwyczajem jest brać argumenty _perldoc -v_ w pojedynczy cudzysłów.

Cała dokumentacja znajduje się też [online](http://perldoc.perl.org/).

### Przydatne strony dokumentacji
````sh
perldoc perlintro # krótkie wprowadzenie do języka
perldoc perlstyle # styl kodu
perldoc perlcheat # ściąga ze wszystkich podstawowych elementów składni
perldoc perltrap  # pułapki i niuanse języka, na które trzeba uważać
````

## Zmienne
Zmiennne w Perlu zaczynają się od znaku oznaczającego ich typ, deklaracja
zmiennych odbywa się za pomocą słowa kluczowego _my_:
````perl
my $scalar;
my @array;
my %hash;
````

### Skalary
Skalary to zmienne przechowujące pojedynczą wartość, może to być liczba,
napis, uchwyt do pliku lub referencja (Perl nie posiada wbudowanych wartości
_true_ i _false_). Konwersja między typami jest dynamiczna i zależy od
kontekstu, po przypisaniu wartość może zmieniać się dowolnie.

#### Deklaracja z inicjalizacją
````perl
my $string = 'hue';
my $number = 7;
my ($a, $b, $c) = (1, 'two', 3.0);
````
Niezainicjalizowane skalary mają specjalną wartość **undef**, wbudowana
funkcja **defined** służy do sprawdzania, czy skalar ma zdefiniowaną
wartość. Próba użycia niezdefiniowanej wartości skutkuje ostrzeżeniem.

#### Liczby
Perl obsługuje liczby całkowite i zmiennoprzecinkowe. Możliwe jest kilka
różnych notacji:
````perl
my $int       = 42;       # liczba całkowita
my $float     = 0.04;     # ułamek
my $sci_float = 1.15e8;   # notacja naukowa
my $binary    = 0b101010; # system dwójkowy
my $hex       = 0x20;     # system szesnastkowy
my $octal     = 052;      # system ósemkowy
````
**UWAGA:** Liczba całkowita rozpoczynająca się od zera jest zawsze
traktowana jako ósemkowa.

Rozdzielanie długich liczb (te trzy instrukcje mają taki sam efekt):
````perl
my $billion = 1000000000;
my $billion = 1_000_000_000;
my $billion = 10_0_00_00_0_0_0;
````

Operacje arytmetyczne:
````perl
7 + 2 - 12 * 5 / 3; # standardowe operatory do podstawowych działań
2**10;              # potęgowanie, wynik - 1024
11 % 4;             # modulo, wynik - 3
++$num1; --$num2;   # pre-inkrementacja i pre-dekrementacja
$num++; $num--;     # post-inkrementacja i post-dekrementacja
````

#### Napisy
Napisy nie mają określonej zawartości ani formatowania.  Mogą przechowywać 
dowolne ilości tesktu lub binarnych danych (o ile pozwala na to pamięć).
Do tworzenia napisów wewnątrz programów najczęściej używa się cudzysłowia:
````perl
my $string = 'bardzo ciekawy \tekst';
my $text = "To jest $string.\n";
````
Pojedynczy cudzysłów służy do interpretacji dosłownej, każdy znak wewnątrz
zostanie bez zmian wstawiony do zmiennej. Podwójny cudzysłów pozwala na
interpolację znaków specjalnych (np. \t, \n) i innych zmiennych.
W efekcie $string zawiera dokładnie _'bardzo ciekawy \tekst'_, a $text
_'To jest bardzo ciekawy \tekst'_ i znak nowej linii. Znaki cudzysłowów w
odpowiednich reprezentacjach napisów można zawrzeć poprzedzając je znakiem
**\**.

Alternatywnie można też użyć funkcji **q** i **qq**, które działają
jak, odpowiednio, pojedynczy i podwójny cudzysłów, ale pozwalają wybrać
inny znak do ograniczenia napisu:
````perl
my $quote = qq{"Przaśnie!", takom rzekł. "Hue hue!"};
my $other = q|It's very weird, don't you think?|;
````
W tym wypadku znak następujący po nazwie funkcji zostaje ograniczeniem
napisu.

Dla większej ilości tekstu warto rozważyć użycie **heredoc**.
````perl
my $text =<<'END_HERE';
Jakiś bardzo długi tekst, który
jest wpisywany do zmiennej $text
bez interpolacji i ze wszystkimi
cudzysłowami: 'cytat'.
END_HERE
````
Dokument heredoc rozpoczyna << i nazwa ogranicznika. Ogranicznik powinien
być wzięty w pojedynczy lub podwójny cudzysłów, jego rodzaj określa
zachowanie interpolacji wewnątrz dokumentu.

**UWAGA:** Niezależnie od indentacji początku dokumentu, zakończenie musi
zaczynać się od początku linii.
````perl
unless (defined $text) {
    $text = <<'END_HERE';
    Dokuement, lorem ipsum
    i coś tam dalej.
END_HERE
}
````

##### Operacje na napisach
Konkatenacja (łączenie) napisów:
````perl
my $string = 'first' . ' and ' . "second\n"; # wynik: "first and second\n"
my $and_zero = 'zeroth and ' . $string;      # wynik: "zeroth and first and second\n"
````
Zmiana wielkości liter:
````perl
uc 'low';      # wynik: 'LOW'
ucfirst 'low'; # wynik: 'Low'
lc 'UP';       # wynik: 'up'
lcfirst 'UP';  # wynik: 'uP'
````
Wielokrotność napisu:
````perl
'hue ' x 3; # wynik: hue hue hue 
````

### Tablice
Tablice są pojemnikami przechowującymi 0 lub więcej skalarów. Dostęp do
elementów jest sekwencyjny, można je dowolnie dodawać i usuwać, a tablica
będzie zmieniać swój rozmiar w miarę potrzeby.

#### Deklaracja z inicjalizacją 
Tablice oznaczone są znakiem **@**. Deklaracja bez inicjalizacji stworzy pustą
(0-elementową) tablicę, do inicjalizcji można użyć listy.
````perl
my @array;                   # pusta tablica
my @array = ('one', 2, 3.0); # tablica zawierająca trzy wartości
````
Jak można zauważyć powyżej, typ skalarów wewnątrz jednej tablicy jest dowolny.

#### Dostęp do elementów
Do pojedynczego elementu tablicy można się odwołać używając standardowego
operatora []. Należy zwrócić uwagę, że pojedynczy element tablicy jest
skalarem, więc należy go poprzedzić znakiem **$**, a nie **@**. Próba dostępu
do elementu, którego nie ma w tablicy zwraca wartość _undef_.
````perl
my @array = ('one', 2, 3.0);
$array[0]; # 'one'
$array[2]; # 3.0
$array[5]; # undef
````
Istnieje też możliwość odwołania się do elementu na podstawie jego pozycji
licząc od końca tablicy, używając indeksów ujemnych:
````perl
my @array = ('one', 2, 3.0);
$array[-1]; # 3.0
$array[-3]; # 'one'
$array[-7]; # undef
````
Przypisanie tablicy do listy pozwala nam na dostęp do określonej liczby
elementów tablicy, licząc od początku.
````perl
my @array = ('one', 2, 3.0);
my ($one, $two, $three) = @array;
$one;   # 'one'
$two;   # 2
$three; # 3.0
````
Tej składni można też użyć do deklaracji kilku skalarów naraz:
````perl
my ($a, $b, $c) = ('anything', 234, 3.5);
````
oraz do zamiany wartości skalarów:
````perl
($a, $b) = ($b, $a);
$a; # 234
$b; # 'anything'
````

#### Pojemność tablicy
Tablice powiększają sie i zmniejszają w miarę potrzeb. Przypisanie wartości do
nieistniejącego elementu, rozszerzy tablicę na tyle, żeby taki element w niej
był.
````perl
my @array = (1, 2, 3);
$array[6] = 'hue';
@array; # (1, 2, 3, undef, undef, undef, 'hue')
````
Do tablicy dodane zostało tyle elementów, by indeks 6 istniał, a pośrednie
wartości zostały ustawione na _undef_.

Zmienna **$#array** zawiera ostatni indeks w tablicy **@array**. Przypisanie do
niej wartości liczbowej zmienia rozmiar tablicy.
````perl
my @array = 1..3; # @array = (1, 2, 3)
$#array;          # 2
$#array = 5;      # @array = (1, 2, 3, undef, undef, undef)
$#array = 1;      # @array = (1, 2)
````

#### Operacje na tablicach
Dodawanie i usuwanie wartości na końcu tablicy:
````perl
my @array;
push @array, 1;        # @array = (1)
push @array, 2, 3;     # @array = (1, 2, 3)
pop @array;            # @array = (1, 2)
my $last = pop @array; # @array = (1), $last = 2
````
Funkcja **push** dodaje podaną listę na koniec tablicy i zwraca nowy rozmiar
tablicy, **pop** usuwa i zwraca ostatni element tablicy.

Funkcje **shift** i **unshift** analogicznie usuwają i dodają elementy na
początku tablicy.

#### Podtablice
Oprócz pojedynczych elementów, operator [] pozwala też uzyskać dostęp do
podtablic.
````perl
my @array = a..g;         # @array = (a, b, c, d, e, f, g)
@array[0,1,5];            # (a, b, f)
@array[3,5] = ('X', 'X'); # @array = (a, b, c, X, e, X, g)
````

#### Kontekst
W kontekście listy, tablice "rozpakowują się" do formy list. Pozwala to na
składanie dowolnej liczby tablic i skalarów w listę.
````perl
my @x = ('x', 'X');
my @y = ('y', 'Y');
my @combo = (@x, 4, @y); # @combo = ('x', 'X', 4, 'y', 'Y')
my ($first, $second, @rest) = 1..10;
$first;  # 1
$second; # 2
@rest;   # (3, 4, 5, 6, 7, 8, 9, 10)
````
W kontekście skalara, tablice zwracają liczbę swoich elementów. Kontekst
skalarny jest wymuszany przez słowo kluczowe **scalar** i operatory skalarne.
````perl
my @array = 1..5; # @array = (1, 2, 3, 4, 5)
scalar @array;    # 5
@array + 2;       # 7
````
**UWAGA:** Należy zwrócić uwagę, że argumenty funkcji (jak **print** i **say**)
są listą, więc następująca próba wypisania ilości elementów tablicy się nie
powiedzie:
````perl
print 'Tablica @array ma ', @array, ' elementów';
````
Tablica @array zostanie rozpakowana do listy swoich elementów, więc efekt
będzie taki sam, jak podanie jej elementów jako argumentów **print**. Wynik
powyższego polecenia to:
````
Tablica @array ma 12345 elementów
````
Żeby podać liczbę argumentów jako argument funkcji należy zawsze używać słowa
kluczowego **scalar**.

Wewnątrz napisu tablica rozwija się w listę argumentów połączoną zawartością
specjalnej zmiennej $", domyślnie jest to pojedyncza spacja.
````perl
my @array = ('kilka', 'słów o tablicy', 'i', 'jedno', 'więcej');
say "Zawartość tablicy: @array";
say 'Tablica zawiera ', scalar @array, ' elementów';
local $" = ')(';
say "Zawartość tablicy: (@array)";
````
Wynik:
````
Zawartość tablicy: kilka słów o tablicy i jedno więcej
Tablica zawiera 5 elementów
Zawartość tablicy: (kilka)(słów o tablicy)(i)(jedno)(więcej)
````

## Logika
### Podstawowe instrukcje warunkowe
````perl
if ($warunek) {
    ...;
} elsif ($inny_warunek) {
    ...;
} else {
    ...;
}
````
**UWAGA:** Klamry dookoła bloku kodu są obowiązkowe, nawet przy pojedynczej
instrukcji.

Do pojedynczych instrukcji można stosować wersję postfixową:
````perl
print 'Warunek spełniony' if $warunek;
````

Istnieje również zanegowana wersja instrukcji **if** - **unless**.

### Operator ternarny
W Perlu można korzystać z operatora ternarego w takiej samej formie jak w C.
````perl
print $warunek ? 'True' : 'False';
````
jest efektywnie tym samym, co:
````perl
if ($warunek) {
    print 'True';
} else {
    print 'False';
}
````
### Operatory logiczne
#### Operatory z kontekstem logicznym
* and, && - koniunkcja
* or, ||  - alternatywa
* not, !  - zaprzeczenie
Mimo, że przy pojedynczym wyrażeniu operatory **and** i **&&** mają ten sam
efekt, to należy pamiętać, że są to dwa różne operatory. Operator *&&** ma
wyższy priorytet niż **and**. To samo tyczy się operatorów **or** i **||**.

#### Operatory z kontekstem numerycznym
* <  - mniejszość
* >  - większość
* <= - mniejszy lub równy
* >= - większy lub równy
* == - równość
* != - nierówność
Wszystkie te operatory narzucają na swoje operandy kontekst numeryczny, nie
należy ich używać do operacji na napisach.

#### Operatory z kontekstem napisowym
* lt - mniejszość
* gt - większość
* le - mniejszy lub równy
* ge - większy lub równy
* eq - równość
* ne - nierówność
Adekwatnie, ten zestaw operatorów służy do operacji na napisach, narzuca na
operandy kontekst napisowy i porównuje je leksykograficznie.

### Kontekst logiczny
Operatory logiczne oraz instrukcje warunkowe narzucają kontekst logiczny. Perl
nie dostarcza typu logicznego (bool), za to wszystkie wbudowane typy Perla mogą
być interpretowane w kontekście logicznym.

#### Liczby
Liczby w kontekście logicznym zachowują się tak samo jak w C, tzn. 0 jest
uznawane za fałsz, a wszystkie inne wartości za prawdę.

#### Napisy
Pusty napis jest interpretowany jako fałsz, wszystkie niepuste napisy (nawet
zawierające same białe znaki) są uznawane za prawdę.

#### Undef
Wartośc _undef_ jest zawsze traktowana jako fałsz.

#### Tablice, listy i hashe
Jeśli dany pojemnik lub lista jest pusty, jest interpretowany jak fałsz, jeśli
zawiera chociaż jeden element (nawet _undef_), jest uznawany za prawdę.
