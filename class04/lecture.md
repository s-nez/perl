# Warsztat 04

<!--TOC_START--->
## Spis treści
* [Wbudowane funkcje listowe](#wbudowane-funkcje-listowe)
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

## Wbudowane funkcje listowe
### sort
Funkcja **sort** służy do sortowania list. Domyślnie sortuje elementy
leksykograficznie. Aby uzyskać inny rodzaj sortowania możemy przekazać
do sort funkcję, która zwraca -1, jeśli pierwszy argument jest większy,
1 jeśli drugi i 0 jeśli argumenty są równe. Wewnątrz tej funkcji mamy
dostęp do dwóch porównywanych wartości przez zmienne **$a** i **$b**.
```perl
my @nums = (1, 23, 43, 12, 876, 3242, 453, 33131, 24, 520, 3, 45543);
say 'Default: ', join ', ', sort @nums;
say 'Numeric: ', join ', ', sort { $a <=> $b } @nums;
say 'Inverse: ', join ', ', sort { $b <=> $a } @nums;
```
Wynik:
```
Default: 1, 12, 23, 24, 3, 3242, 33131, 43, 453, 45543, 520, 876
Numeric: 1, 3, 12, 23, 24, 43, 453, 520, 876, 3242, 33131, 45543
Inverse: 45543, 33131, 3242, 876, 520, 453, 43, 24, 23, 12, 3, 1
```

Sortowanie napisów według długości:
```perl
my @words = qw(joke test max goto break continue);
say join ', ', sort { length $a <=> length $b } @words;
```
Wynik:
```
max, joke, test, goto, break, continue
```

### map
Funkcja **map** pozwala przekształcać listy. Przyjmuje funkcję i listę jako 
argumenty i wykonuje funkcję na każdym elemencie listy. Do aktualnego
elementu listy można się dostać przez domyślną zmienną **$\_**.

Stworzenie listy potrojonych liczb:
```perl
my @nums = 1 .. 10;
my @tripled = map { $_ * 3 } @nums;
say "@nums";
say "@tripled";
```

Wynik:
```
1 2 3 4 5 6 7 8 9 10
3 6 9 12 15 18 21 24 27 30
```

Zamiana napisów na ciągi gwiazdek:
```perl
my @passwords = qw(hunter2 password abc123 verydifficult easy);
local $, = ' ';
say @passwords;
say map { '*' x length } @passwords;
```

Wynik:
```
hunter2 password abc123 verydifficult easy
******* ******** ****** ************* ****
```

Generowanie tablicy losowych liczb:
```perl
my @random = map { int rand 100 } 1 .. 10;
```

### grep
**grep** jest funkcją filtrującą. Przyjmuje funkcję i listę jako argument,
zwraca te elementy listy, dla których funkcja zwraca prawdę. Tak samo jak
w przypadku **map**, do aktualnego elementu listy możemy się dostać przez
**$\_**.

Odrzucenie niezdefiniowanych wartości z tablicy:
```perl
my @array = (1, 2, 3, 4, undef, 6, 7, undef, undef, 10);
@array = grep { defined } @array;
say "@array";
```

Wynik:
```
1 2 3 4 6 7 10
```

Wybranie liczb z konkretnego przedziału:
```perl
my @array = 1 .. 100;
my ($start, $end) = (50, 60);
local $, = ', ';
say grep { $start <= $_ and $_ <= $end } @array;
```

Wynik:
```
50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
```

### Łączenie wywołań
Każda z funkcji **sort**, **map** i **grep** przyjmuje listę jako argumentów
i zwraca listę. Pozwala to na łączenie wywołań tych funkcji.

Dopisanie długości do posortowanego malejąco podzbioru napisów o długości
większej niż 5:
```perl
my @strings = qw(short long verylong testete hueuehuehue blah heh grr warrr);
local $, = "\n";
say map { $_ . "(" . length . ")" } sort { length $b <=> length $a } grep { length > 5 } @strings;
```

Wynik:
```
hueuehuehue(11)
verylong(8)
testete(7)
```

Sortowanie leksykograficznie pełnych nazw normalnych użytkowników
z /etc/passwd:
```perl
open my $passwd, '<', '/etc/passwd';
local $, = "\n";
say sort map { (split ':')[4] } grep { my $uid = (split ':')[2]; 1000 <= $uid and $uid <= 60000 } <$passwd>;
```

## Zagnieżdżone struktury danych
Kontenery (tablice i hasze) mogą przetrzymywać tylko skalary, nie mogą
przechowywać innych kontenerów. Dlatego do tworzenia rozbudowanych struktur
danych używa się referencji.

### Referencje
Referencja jest specjalnym skalarem, który wskazuje na inną zmienną.
Aby uzyskać referencję do istniejącej zmiennej używa się operatora **\**.
```perl
my @array = 1 .. 10;
my $array_ref = \@array;
```
Zmiana wartości wskazywanej przez referencję spowoduje zmianę we wskazywanej
zmiennej. Do uzyskania dostępu do wskazywanej zmiennej można użyć operatora
**->**:
```perl
$array_ref->[2] = 'changed';
@array; # (1, 2, changed, 4, 5, 6, 7, 8, 9, 10)
```
podwójnego znaku kluczowego:
```perl
$$array_ref[3] = 'X';
@array; # (1, 2, changed, X, 5, 6, 7, 8, 9, 10)
```
lub bloku interpolacyjnego:
```perl
${ $array_ref }[4] = 'wat';
@array; # (1, 2, changed, X, wat, 6, 7, 8, 9, 10)
```
Te same zasady dotyczą referencji do haszy:
```perl
my %hash;
my $hash_ref = \%hash;
%$hash_ref; %{ $hash_ref }; # hasz wskazywany przez hash_ref
$hash_ref->{key};           # klucz w haszu wskazywanym przez hasz_ref
```

#### Anonimowe zmienne
Oprócz tworzenia referencji do istniejących nazwanych zmiennych, można też
tworzyć zmienne anonimowe.
```perl
my $scalar_ref = \12;
my $array_ref  = [1, 2, 3, 4];
my $hash_ref   = { key => 'value', number => 14 };
```
Do anonimowych zmiennych można odwoływać się tylko i wyłącznie przez
referencje.

### Wielowymiarowe tablice
W kontekście listowym nie ma możliwości separowania list, dlatego 
następująca próba stworzenia dwuwymiarowej tablicy się nie powiedzie:
```perl
my @array2d = ((1,2,3), (4, 5, 6));
```
Listy zostaną połączone w jedną i w efekcie otrzymamy jednowymiarową tablicę
zawierającą elementy wszystkich podanych list.

Bez problemu można jednak stworzyć tablicę referencji do anonimowych tablic:
```perl
my @array2d = ([1, 2, 3], [4, 5, 6]);
```
Do elementów takich zagnieżdżonych tablic można się dostać operatorem **->**:
```perl
$arry2d[0]->[0] = 42;
@array2d; # ([42, 2, 3], [4, 5, 6])
```
Jako, że referencje są jedynym sposobem na tworzenie zagnieżdżonych struktur
danych, nie ma żadnego problemu, by pominąć operator **->**:
```perl
$arry2d[0][0] = 42;
```

### Inne rodzaje zagnieżdżonych struktur danych
Struktury danych można dowolnie łączyć i zagnieżdżać. W identyczny sposób
jak wielowymiarowe tablice, możemy tworzyć tablice haszy, hasze tablic,
hasze haszy, tablice haszy tablic tablic, itd.

### Autovivification
Perl dostosowuje się do programisty. Jeśli potraktujemy niezdefiniowany
skalar jak referencję, stanie się on referencją. Działa to na dowolnym poziomie
zagnieżdżenia i pozwala tworzyć w locie dowolne struktury danych.
```perl
my $var;
$var->[0]{Key}[4] = 'we need to go deeper';
```
W powyższym przykładzie skalar **$var** został potraktowany jako referencja do
tablicy, zawierającą hasz tablic. Cała struktura została stworzona wedle
zapotrzebowania i **$var** faktycznie jest teraz referencją do wymaganej
struktury.

### Data::Dumper
**Data::Dumper** jest wbudowanym modułem, który pozwala wyświetlić dowolną
strukturę danych. Aby go użyć należy dodać do programu:
```perl
use Data::Dumper;
```
Teraz możemy wypisać dowolną strukturę danych funkcją **Dumper**.
```perl
my @array2d = ([1, 2, 3], [4, 5, 6]);
my $var;
$var->[0]{Key}[4] = 'we need to go deeper';
print Dumper(\@array2d, $var);
```
Wyjście:
```
$VAR1 = [
          [
            1,
            2,
            3
          ],
          [
            4,
            5,
            6
          ]
        ];
$VAR2 = [
          {
            'Key' => [
                       undef,
                       undef,
                       undef,
                       undef,
                       'we need to go deeper'
                     ]
          }
        ];
```

**UWAGA:** Do wyświetlania struktur zaczynających się od nazwanych
kontenerów lepiej jest przekazać referencję, w przeciwnym przypadku startowy
kontener zostanie "spłaszczony" do postaci listy.

## Transformata Schwartza
Przy przetwarzaniu danych często zdarza się, że należy je posortować
względem jakiejś cechy, której uzyskanie wymaga dodatkowej obróbki.
Najprostszym przykładem takiej cechy jest długość:
```perl
sort { length $a <=> length $b } @data;
```

Transformata Schwartza to idiom Perla, który polega na wykonaniu
obróbki całego zestawu danych przed rozpoczęciem sortowania i przywróceniu
zestawu do prawidłowej postaci po jego zakończeniu. Załóżmy, że sortujemy
dane według wartości funkcji **extract()**, która zwraca liczbę.

Sortowanie używające bezpośredniego wywołania **extract()**:
```perl
sort { extract($a) <=> extract($b) } @data;
```

Transformata Schwartza:
```perl
map { $_->[0] }
sort { $a->[1] <=> $b->[1] }
map { [ $_, extract($_) ] } @data;
```
Czytając od tyłu - najpierw do każdego elementu **@data** jest
przyporządkowana para [ ORYGINAŁ, CECHA ], gdzie ORYGINAŁ to element
tablicy **@data**, a CECHA to wartość, według której będziemy sortować.
Następnie pary zostają posortowane według wartości drugiego elementu (czyli
CECHA). Na koniec do każdej pary zostaje przyporządkowany jej pierwszy
element, innymi słowy, CECHA zostaje odrzucona i zostają same wartości
oryginalne, odpowiednio posortowane.
