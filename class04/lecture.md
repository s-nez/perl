# Warsztat 04

<!--TOC_START--->
## Spis treści
* [Wyrażania regularne](#wyrażania-regularne)
    * [Operator dopasowania wzorca](#operator-dopasowania-wzorca)
    * [Wzorce, a zmienne](#wzorce-a-zmienne)
    * [Metaznaki](#metaznaki)
        * [Klasy znaków](#klasy-znaków)
        * [Miejsca w napisie](#miejsca-w-napisie)
    * [Krotność](#krotność)
        * [Zero lub jeden raz](#zero-lub-jeden-raz)
        * [Raz lub więcej](#raz-lub-więcej)
        * [Dowolna ilość](#dowolna-ilość)
        * [Przedział liczbowy](#przedział-liczbowy)
    * [Grupowanie i przechwytywanie](#grupowanie-i-przechwytywanie)
        * [Grupy elementów](#grupy-elementów)
        * [Przechwytywanie podnapisów](#przechwytywanie-podnapisów)
        * [Listy podnapisów](#listy-podnapisów)
        * [Grupowanie bez przechwytywania](#grupowanie-bez-przechwytywania)

<!--TOC_END--->

## Wyrażania regularne
Wyrażania regularne pozwalają na dopasowanie tekstu do pewnego wzorca.
Najprostszym ich zastosowaniem jest sprawdzenie, czy napis zawiera
jakiś konkretny podnapis (chociaż akurat do tego funkcja **index** może
się lepiej nadawać). Ogólniej, wyrażenia regularne pozwalają w bardzo
rozbudowany sposób uzyskiwać informacje o tekście i danych w nim zawartych.

### Operator dopasowania wzorca
Do operowania na wyrażeniach regularnych używa się dwóch operatorów:
**=~** i **!~**, lewy operand jest napisem, a prawy wzorcem do dopasowania.
Wzorce są ciągami znaków otoczonymi znakami ograniczajacymi
(domyślnie **/**, ale można też użyć innego).

W kontekście logicznym operator **=~** zwraca prawdę, jeśli napis zawiera
wzorzec. **!~** jest zwykłą negacją tego operatora.
```perl
if ('this is a test' =~ /this/) {} # True
if ('this is a test' !~ /this/) {} # False
if ('that is a test' =~ /this/) {} # False
```

Operator dopasowania można pominąć przy operacjach na zmiennej **$_**.
Poniższy kod wypisuje wszystkie elementy tablicy, które zawierają dwie
litery 'e' następujące po sobie.
```perl
my @array = qw(wheel balls creed bleed wrath mouse);
foreach (@array) {
    say if /ee/;
}
```
Wynik:
```
wheel
creed
bleed
```

Aby użyć innego znaku ograniczającego, należy dodać oznaczenie trybu do 
wyrażenia. Domyślny tryb (dopasowanie) oznacza się przez **m**.

Te trzy linie są równoznaczne:
```perl
say if /ee/;
say if m+ee+;
say if m{ee};
```

### Wzorce, a zmienne
Wzorce można zapisywać w zmiennych za pomocą operatora **qr**.

Wszystkie dopasowania poniżej są równoznaczne:
```perl
my $regex   = qr/abc/;
my $same_rx = qr(abc);
'abcdef' =~ /abc/;
'abcdef' =~ $regex;
'abcdef' =~ $same_rx;
```

W zakresie interpolacji, wzroce zachowują się jak podwójny cudzysłów,
to znaczy, że można używać zmiennych jako części wzorca.

Dopasowanie z interpolacją zmiennej:
```perl
my $text = 'abc';
'abcdef' =~ /$text/;
```

Jako, że wzorce często są zbitkami dużej ilości tekstu, dla bezpieczeństwa,
lepiej jest interpolować zmienne w następujący sposób:
```perl
my $text = 'abc';
'abcdef' =~ /${text}/;
```

Pozwala to uniknąć błędów w odczycie nazw zmmiennych.
```perl
my $system = 'unix';
'abcunixd' =~ /$systemd/;
```
W powyższym przykładzie parser próbuje interpolować zmienną **$systemd**,
która nie istnieje. Z włączonym **strict** będzie to błąd kompilacji,
bez **strict** będzie to dopasowanie pustego wzorca.

Poprawne dopasowanie _"zawartości zmiennej **$system** i d"_:
```perl
my $system = 'unix';
'abcunixd' =~ /${system}d/;
```

### Metaznaki
Oprócz dosłownych znaków, wzorce mogą zawierać również metaznaki, które
opisują jakiś podzbiór wszystkich znaków, miejsce w napisie lub pozwalają
zdefiniować bardziej złożone wzorce.

#### Klasy znaków
Klasy znaków są podzbiorami zbioru znaków. Dopasowanie do klasy dopasowuje
dowolny znak w niej zawarty. Klasy znaków definiuje się przez nawiasy
kwadratowe. Wzorzec:
```perl
m/[abc]def/
```
będzie pasował do trzech napisów:
```
'adef'
'bdef'
'cdef'
```

Klasy mogą również zawierać zakresy znaków, wzorzec powyżej można zapisać
również jako:
```perl
m/[a-c]def/
```

W jednej klasie może znajdować się kilka zakresów, np. żeby dopasować
litery od 'd' do 'g' i cyfry od 1 do 7:
```perl
m/[d-g1-7]/
```

Jeśli pierwszym znakiem w klasie jest **^**, to jest to klasa zanegowana,
dopasowuje wszystko, oprócz zawartych w niej znaków. Poniższy wzorzec
dopasowuje wszystkie znaki oprócz cyfr:
```perl
m/[^0-9]/
```

##### Klasy wbudowane
Kilka często używanych klas jest dostępnych jako znaki specjalne wewnątrz
wzorców:
* **\s** - znaki białe (spacje, taby, entery)
* **\S** - negacja **\s**, wszystkie niebiałe znaki
* **\d** - cyfry
* **\D** - wszystko oprócz cyfr
* **\w** - znaki _"słowne"_, wszystkie znaki alfanumeryczne i '_'
* **\W** - negacja **\w**, znaki niealfanumeryczne
* **.**  - dowolny znak oprócz _"\n"_

#### Miejsca w napisie
Kilka metaznaków dopasowuje miejsca w napisie zamiast zbioru liter, są to
dopasowania o zerowej długości.

##### Początek i koniec napisu
Znak **\A** dopasowuje początek napisu.
Poniższy wzorzec pasuje do wszystkich napisów zaczynających się od słowa
"break":
```perl
m/\Abreak/
```
Będzie więc pasował do m. in. do następujących napisów:
```perl
"break"
"breakthrough"
"breaks"
"break and something else"
```
ale już nie do:
```perl
"have a break"
"no breaks"
```

W podobny sposób znak **\z** dopasowuje koniec napisu. Jako, że wczytywane dane
często kończą się znakiem nowej linii, mamy również do dyspozycji znak **\Z**,
który pasuje do końca napisu lub znaku nowej linii kończącego napis:
```perl
"more text" =~ /text\z/;   # True
"more text" =~ /text\Z/;   # True
"more text\n" =~ /text\z/; # False
"more text\n" =~ /text\Z/; # True
```

Otoczenie całego wzorca znakami **\A** i **\Z** (lub **\z**) pozwala tworzyć
dopasowania całego napisu.
```perl
"lorem ipsum" =~ /\Alorem ipsum\Z/;                # True
"lorem ipsum dolor sit amet" =~ /\Alorem ipsum\Z/; # False
"sit lorem ipsum" =~ /\Alorem ipsum\Z/;            # False
```

##### Brzeg słowa
Znak **\b** dopasowuje brzeg słowa, tzn. miejsce między znakiem
alfanumerycznym, a znakiem białym. Poniższy kod wypisuje wszystkie elementy
tablicy, które zawierają słowo zaczynające się ciągiem znaków "abc":
```perl
my @array = ('abc', 'abcdef', 'mrabc', 'hue abcd de', 'moar hue rabc');
foreach (@array) {
    say if m/\babc/;
}
```
Wynik:
```
abc
abcdef
hue abcd de
```

### Krotność
Każdy element wzorca może mieć zdefiniowaną krotność. To znaczy, że do wzorca
można dopasować dowolną ilość wystąpień danego elementu. Krotność elementu
określa się przez dodanie do niego odpowiedniego kwantyfikatora.

#### Zero lub jeden raz
Kwantyfikator **?** oznacza 0 lub 1 wystąpienie. To znaczy, że poniższy
wzorzec:
```perl
m/abcd?/
```
będzie pasował do napisów:
```perl
'abc'
'abcd'
```

**UWAGA:** Kwantyfikatory mają wpływ tylko na element bezpośrednio
je poprzedzający (znak, klasę znaków lub grupę). W powyższym przykładzie,
kwantyfikator **?** dotyczy tylko i wyłącznie znaku 'd'.

#### Raz lub więcej
Kwantyfikator **+** pasuje do liczby wystąpień większej lub równej jeden.

Wzorzec:
```perl
m/hu+e/
```
pasuje m. in. do napisów:
```perl
'hue'
'huue'
'huuue'
'huuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuue'
```
Ale nie pasuje już do:
```perl
'he'
```

#### Dowolna ilość
Kwantyfikator __*__ dopasowuje dowolną ilość wystąpień elementu. Może on nie
występować w ogóle, występować raz, dwa, trzy, itd.

Wzorzec:
```perl
m/hu*e/
```
będzie pasował m. in. do:
```perl
'he'
'hue'
'huue'
'huuue'
'huuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuue'
```

#### Przedział liczbowy
Dwuargumentowy kwantyfikator **{$a, $b}** pozwala zdefiniować przedział, w
którym ma się znajdować liczba wystąpień elementu.

Wzorzec:
```perl
m/a{1,5}/
```
oznacza "znak 'a' występujący co najmniej raz, ale nie więcej niż 5 razy".

Pominięcie drugiego argumentu znosi górne ograniczenie, tzn. **{2,}**
oznacza _"co najmniej dwa razy"_.

Podanie jednego argumentu bez przecinka dopasowuje dokładną ilość wystąpień,
**{2}** jest tym samym, co **{2,2}**.

### Grupowanie i przechwytywanie
#### Grupy elementów
Wzięcie sekwencji elementów wzorca w okrągłe nawiasy stworzy z nich grupę,
na zewnątrz nawiasów sekwencja ta będzie traktowana jako pojedynczy element.
Pozwala to stosować kwantyfikatory do całych sekwencji.

Np. jeśli chcemy dopasować dość długi śmiech:
```perl
m/(ha){3,}/
```
Taki wzorzec będzie pasował do:
```perl
'hahaha'
'hahahaha'
'hahahahahahaha'
```

#### Przechwytywanie podnapisów
Nawiasy okrągłe oprócz grupowania elementów przypisują dopasowane podnapisy
do specjalnych zmiennych, **$1**, **$2**, itd. Oznaczają one
odpowiednio _"zawartość pierwszego nawiasu"_, _"zawartość drugiego nawiasu"_,
itd.

Jeśli w którymś z napisów pojawi się numer telefonu, to zostanie on wypisany
na standardowe wyjście:
```perl
my @strings = (
    'napis bez sensu',
    'napis z sensem',
    'zadzwoń pod 112-321-543',
    'hue hue 123943, 2341',
    'policja 997-112',
    'pizzeria "Primo", 324-123-984, promocja 50% zniżki! na pizzę 2cm',
    'no i tu nie ma numeru 999999'
);

foreach (@strings) {
    say $1 if m/(\d{3}-\d{3}-\d{3})/;
}
```

Wyjście:
```
112-321-543
324-123-984
```

Do napisów przechwyconych w ten sposób można sie też odwołać bezpośrednio
wewnątrz wyrażenia regularnego. Zmiennym **$1**, **$2**, **$3**, itd.
odpowiadają znaki specjalne **\g1**, **\g2**, **\g3**, itd.

Wyrażenie dopasowujące pustą parę tagów HTML:
```perl
m{<(\w+)></\g1>}
```

**UWAGA:** Zmiennych **$1**, **$2**, ... nie należy używać wewnątrz wzorca.

#### Listy podnapisów
Użycie wyrażenia regularnego w kontekście listowym zwróci listę wszystkich
przechwyconych podnapisów. Jeśli we wzorcu nie ma ani jednej grupy
przechwytującej, zwracana jest lista dopasowań całego wzorca.

Wyciągnięcie wszystkich 3-cyfrowych liczb z napisu:
```perl
my @matches = 'nums123 fds5 fds341 fdsna102' =~ /\d\d\d/g;
say foreach @matches;
```
Wyjście:
```
123
341
102
```

Wyciągnięcie wszystkich słów w pojedynczych cudzysłowach:
```perl
my $string = q(quotes 'hue', more 'tests', brrr 'cold' and 'all that');
my @matches = $string =~ /'(\w+)'/g;
say foreach @matches;
```
Wynik:
```
hue
tests
cold
```

Modyfikator **/g** na końcu wzorca powoduje przechwycenie wszystkich
dopasowań grup. Użycie wyrażenia regularnego bez tego modyfikatora
spowoduje przechwycenie tylko pierwszego dopasowania.
```perl
my $string = q(quotes 'hue', more 'tests', brrr 'cold' and 'all that');
my @matches = $string =~ /'(\w+)'/;
say foreach @matches;
```
Wynik:
```
hue
```

Warto pamiętać o listach składanych ze skalarów. Używając ich z wyrażeniami
regularnymi, możemy w bardzo prosty sposób odfiltrować potrzebne informacje
z tekstu o znanym formacie. 
```perl
my $log = 'Jan 04 20:20:03 S3 systemd[11935]: Startup finished in 13ms.';
my ($date, $host, $unit, $message) = $log =~ /\A(\w{3} \d\d \d\d:\d\d:\d\d) (\w+) (\w+)\[\d+\]: (.+)\Z/;
print <<"END_LOG"
Date: $date
Hostname: $host
Unit: $unit
Message: $message
END_LOG
```

Wyjście:
```
Date: Jan 04 20:20:03
Hostname: S3
Unit: systemd
Message: Startup finished in 13ms.
```

#### Grupowanie bez przechwytywania
Jeśli nie chcemy zachowywać danej części tekstu, ale potrzebne jest grupowanie,
można na początek zawartości nawiasu dodać **?:**, wtedy będzie to wyłącznie
konstrukt grupujący, bez efektów ubocznych. Nie będzie się też liczył do
numerów zmiennych **$1**, **$2**, itd.

Dopasowanie wzorca _"a, od 2 do 5 sekwencji abc i trzy liczby"_,
bez przechwytywania:
```perl
m/a(?:abc){2,5}\d{3}/
```
