# Warsztat 01

## Instalacja
Perl jest zainstalowy domyślnie w większość dystrybucji GNU. Instalacja
pakietu _perl_ powinna wystarczyć do normalnej pracy.

Jeśli ktoś jest zmuszony do używania Windowsa, to
[Strawberry Perl](http://strawberryperl.com/) wydaje się być najlepszą
opcją.

### Edytor
Najprostszy edytor tekstu i terminal wystarczą do pisania i uruchamiania
programów. [Geany](http://www.geany.org/) jest dobrym wyborem na początek.

## Hello World! i uruchamianie programów
Tradycyjny program Hello World! w Perlu:
````
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
````
perldoc perlintro # krótkie wprowadzenie do języka
perldoc perlstyle # styl kodu
perldoc perlcheat # ściąga ze wszystkich podstawowych elementów składni
perldoc perltrap  # pułapki i niuanse języka, na które trzeba uważać
````

## Zmienne
Zmiennne w Perlu zaczynają się od znaku oznaczającego ich typ, deklaracja
zmiennych odbywa się za pomocą słowa kluczowego _my_:
````
my $scalar;
my @array;
my %hash;
````

### Skalary
Skalary to zmienne przechowujące pojedynczą wartość, może to być liczba,
napis, uchwyt do pliku lub referencja (Perl nie posiada wbudowanych wartości
_true_ i _false_). Konwersja między typami jest dynamiczna i zależy od
kontekstu, po przypisaniu wartość może zmieniać się dowolnie.

#### Deklaracja z inicjalizacją:
````
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
````
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
````
my $billion = 1000000000;
my $billion = 1_000_000_000;
my $billion = 10_0_00_00_0_0_0;
````

Operacje arytmetyczne:
````
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
````
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
````
my $quote = qq{"Przaśnie!", takom rzekł. "Hue hue!"};
my $other = q|It's very weird, don't you think?|;
````
W tym wypadku znak następujący po nazwie funkcji zostaje ograniczeniem
napisu.

Dla większej ilości tekstu warto rozważyć użycie **heredoc**.
````
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
````
unless (defined $text) {
    $text = <<'END_HERE';
    Dokuement, lorem ipsum
    i coś tam dalej.
END_HERE
}
````

##### Operacje na napisach
Konkatenacja (łączenie) napisów:
````
my $string = 'first' . ' and ' . "second\n"; # wynik: "first and second\n"
my $and_zero = 'zeroth and ' . $string;      # wynik: "zeroth and first and second\n"
````
Zmiana wielkości liter:
````
uc 'low';      # wynik: 'LOW'
ucfirst 'low'; # wynik: 'Low'
lc 'UP';       # wynik: 'up'
lcfirst 'UP';  # wynik: 'uP'
````
