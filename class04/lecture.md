# Warsztat 04

<!--TOC_START--->
## Spis treści
* [Wyrażania regularne](#wyrażania-regularne)
    * [Operator dopasowania wzorca](#operator-dopasowania-wzorca)
    * [Metaznaki](#metaznaki)
        * [Klasy znaków](#klasy-znaków)
        * [Miejsca w napisie](#miejsca-w-napisie)

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
