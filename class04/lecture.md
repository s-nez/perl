# Warsztat 04

<!--TOC_START--->
## Spis treści
* [Wyrażania regularne](#wyrażania-regularne)
    * [Operator dopasowania wzorca](#operator-dopasowania-wzorca)
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
wzorzec i fałsz w przeciwnym wypadku. **!~** jest zwykłą negacją tego
operatora.
````perl
if ('this is a test' =~ /this/) {} # True
if ('this is a test' !~ /this/) {} # False
if ('that is a test' =~ /this/) {} # False
````

Operator dopasowania można pominąć przy operacjach na zmiennej **$_**.
Poniższy kod wypisuje wszystkie elementy tablicy, które zawierają dwie
litery 'e' następujące po sobie.
````perl
my @array = qw(wheel balls creed bleed wrath mouse);
foreach (@array) {
    say if /ee/;
}
````
Wynik:
````
wheel
creed
bleed
````

Aby użyć innego znaku ograniczającego, należy dodać oznaczenie trybu do 
wyrażenia. Domślny tryb (dopasowanie) oznacza się przez **m**.

Te trzy linie są równoznaczne:
````perl
say if /ee/;
say if m+ee+;
say if m{ee};
````

### Metaznaki
Oprócz dosłownych znaków, wzorce mogą zawierać również metaznaki, które
opisują jakiś podzbiór wszystkich znaków, miejsce w napisie lub pozwalają
zdefiniować bardziej złożone wzorce.

#### Klasy znaków
Klasy znaków są podzbiorami zbioru znaków. Dopasowanie do klasy dopasowuje
dowolny znak w niej zawarty. Klasy znaków definiuje się przez nawiasy
kwadratowe. Wzorzec:
````perl
/[abc]def/
````
będzie pasował do trzech napisów:
````
adef
bdef
cdef
````

Klasy mogą również zawierać zakresy znaków, wzorzec powyżej można zapisać
również jako:
````perl
/[a-c]def/
````

W jednej klasie może znajdować się kilka zakresów, np. żeby dopasować
litery od 'd' do 'g' i cyfry od 1 do 7:
````perl
/[d-g1-7]/
````

Jeśli pierwszym znakiem w klasie jest **^**, to jest to klasa zanegowana,
dopasowuje wszystko, oprócz zawartych w niej znaków. Poniższy wzorzec
dopasowuje wszystkie znaki oprócz cyfr:
````perl
/[^0-9]/
````

##### Klasy wbudowane
Kilka często używanych klas jest dostępnych jako znaki specjalne wewnątrz
wzorców:
* \s - znaki białe (spacje, taby, entery)
* \S - negacja \s, wszystkie niebiałe znaki
* \d - cyfry
* \D - wszystko oprócz cyfr
* \w - znaki "słowne", wszystkie znaki alfanumeryczne i '_'
* \W - negacja \w, znaki niealfanumeryczne
* .  - dowolny znak oprócz "\n"

#### Miejsca w napisie
Kilka metaznaków dopasowuje miejsca w napisie zamiast zbioru liter, są to
dopasowania o zerowej długości.

##### Początek i koniec napisu
Znak **\A** dopasowuje początek napisu.
Poniższy wzorzec pasuje do wszystkich napisów zaczynających się od słowa
"break":
````perl
/\Abreak/
````
Będzie więc pasował do m. in. do następujących napisów:
````perl
"break"
"breakthrough"
"breaks"
"break and something else"
````
ale już nie do:
````perl
"have a break"
"no breaks"
````

W podobny sposób znak **\z** dopasowuje koniec napisu. Jako, że wczytywane dane
często kończą się znakiem nowej linii, mamy również do dyspozycji znak **\Z**,
który pasuje do końca napisu lub znaku nowej linii kończącego napis:
````perl
"more text" =~ /text\z/;   # True
"more text" =~ /text\Z/;   # True
"more text\n" =~ /text\z/; # False
"more text\n" =~ /text\Z/; # True
````

W połączeniu ze znakami **\Z** i **\z**, **\A** pozwala tworzyć dopasowania
całego napisu.
````perl
"lorem ipsum" =~ /\Alorem ipsum\Z/;                # True
"lorem ipsum dolor sit amet" =~ /\Alorem ipsum\Z/; # False
"sit lorem ipsum" =~ /\Alorem ipsum\Z/;            # False
````

##### Brzeg słowa
Znak **\b** dopasowuje brzeg słowa, tzn. miejsce między znakiem
alfanumerycznym, a znakiem białym. Poniższy kod wypisuje wszystkie elementy
tablicy, które zawierają słowo zaczynające się ciągiem znaków "abc":
````perl
my @array = ('abc', 'abcdef', 'mrabc', 'hue abcd de', 'moar hue rabc');
foreach (@array) {
    say if /\babc/;
}
````
Wynik:
````
abc
abcdef
hue abcd de
````

### Krotność
Każdy element wzorca może mieć zdefiniowaną krotność. To znaczy, że do wzorca
można dopasować dowolną ilość wystąpień danego elementu. Krotność elementu
określa się przez dodanie do niego odpowiedniego kwantyfikatora.

#### Zero lub jeden raz
Kwantyfikator **?** oznacza 0 lub 1 wystąpienie. To znaczy, że poniższy
wzorzec:
````perl
/abcd?/
````
będzie pasował do napisów:
````
'abc'
'abcd'
````

**UWAGA:** Kwantyfikatory mają wpływ tylko na element bezpośrednio
je poprzedzający (znak, klasę znaków lub grupę). W powyższym przykładzie,
kwantyfikator **?** dotyczy tylko i wyłącznie znaku 'd'.

#### Raz lub więcej
Kwantyfikator **+** pasuje do liczby wystąpień większej lub równej jeden.

Wzorzec:
````perl
/hu+e/
````
pasuje m. in. do napisów:
````
'hue'
'huue'
'huuue'
'huuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuue'
````
Ale nie pasuje już do:
````
he
````

#### Dowolna ilość
Kwantyfikator __*__ dopasowuje dowolną ilość wystąpień elementu. Może on nie
występować w ogóle, występować raz, dwa, trzy, itd.

Wzorzec:
````perl
/hu*e/
````
będzie pasował m. in. do:
````
'he'
'hue'
'huue'
'huuue'
'huuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuue'
````

#### Przedział liczbowy
Dwuargumentowy kwantyfikator **{$a, $b}** pozwala zdefiniować przedział, w
którym ma się znajdować liczba wystąpień elementu.

Wzorzec:
````perl
/a{1,5}/
````
oznacza "znak 'a' występujący co najmniej raz, ale nie więcej niż 5 razy".

Pominięcie jednego z argumentów znosi ograniczenia, tzn. **{2,}** oznacza
"co najmniej dwa razy", a **{,2}** "co najwyżej dwa razy".

Podanie jednego argumentu bez przecinka dopasowuje dokładną ilość wystąpień,
**{2}** jest tym samym, co **{2,2}**.

### Grupowanie i przechwytywanie
#### Grupy elementów
Wzięcie sekwencji elementów wzorca w okrągłe nawiasy stworzy z nich grupę,
na zewnątrz nawiasów sekwencja ta będzie traktowana jako pojedynczy element.
Pozwala to stosować kwantyfikatory do całych sekwencji.

Np. jeśli chcemy dopasować dość długi śmiech:
````perl
/(ha){3,}/
````
Taki wzorzec będzie pasował do:
````
'hahaha'
'hahahaha'
'hahahahahahaha'
````

#### Przechwytywanie podnapisów
Nawiasy okrągłe oprócz grupowania elementów przypisują dopasowane podnapisy
do specjalnych zmiennych, **$1**, **$2**, itd. Oznaczają one
odpowiednio "zawartość pierwszego nawiasu", "zawartość drugiego nawiasu", itd.

Jeśli w którymś z napisów pojawi się numer telefonu, to zostanie on wypisany
na standardowe wyjście:
````perl
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
    say $1 if /(\d{3}-\d{3}-\d{3})/;
}
````

Wyjście:
````
112-321-543
324-123-984
````

Do napisów przechwyconych w ten sposób można sie też odwołać bezpośrednio
wewnątrz wyrażenia regularnego. Zmiennym **$1**, **$2**, **$3**, itd.
odpowiadają znaki specjalne **\g1**, **\g2**, **\g3**, itd.

Wyrażenie dopasowujące pustą parę tagów HTML:
````perl
m{<(\w+)></\g1>}
````

#### Grupowanie bez przechwytywania
Jeśli nie chcemy zachowywać danej części tekstu, ale potrzebne jest grupowanie,
można na początek zawartości nawiasu dodać **?:**, wtedy będzie to wyłącznie
konstrukt grupujący, bez efektów ubocznych. Nie będzie się też liczył do
numerów zmiennych **$1**, **$2**, itd.

Dopasowanie a, od 2 do 5 sekwencji abc i trzech liczb, bez przechwytywania:
````perl
/a(?:abc){2,5}\d{3}/
````