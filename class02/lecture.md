# Wyrażenia regularne

<!--TOC_START--->
## Spis treści
* [Operator dopasowania wzorca](#operator-dopasowania-wzorca)
* [Wzorce, a zmienne](#wzorce-a-zmienne)
* [Metaznaki](#metaznaki)
    * [Klasy znaków](#klasy-znaków)
        * [Klasy wbudowane](#klasy-wbudowane)
    * [Miejsca w napisie](#miejsca-w-napisie)
        * [Początek i koniec napisu](#początek-i-koniec-napisu)
        * [Brzeg słowa](#brzeg-słowa)
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
* [Alternatywa](#alternatywa)
* [Chciwe i skąpe dopasowania](#chciwe-i-skąpe-dopasowania)
* [Modyfikatory dopasowań](#modyfikatory-dopasowań)
    * [/i](#i)
    * [/s](#s)
    * [/x](#x)
* [Quotemeta](#quotemeta)
* [Zamiana dopasowań](#zamiana-dopasowań)
    * [Modyfikatory zamiany](#modyfikatory-zamiany)
        * [/r](#r)
        * [/e](#e)
* [Nazwane grupy](#nazwane-grupy)
* [Sprawdzenia (assertions)](#sprawdzenia-assertions)

<!--TOC_END--->

Wyrażania regularne pozwalają na dopasowanie tekstu do pewnego wzorca.
Najprostszym ich zastosowaniem jest sprawdzenie, czy napis zawiera
jakiś konkretny podnapis (chociaż akurat do tego funkcja **index** może
się lepiej nadawać). Ogólniej, wyrażenia regularne pozwalają w bardzo
rozbudowany sposób uzyskiwać informacje o tekście i danych w nim zawartych.

## Operator dopasowania wzorca
Do operowania na wyrażeniach regularnych używa się dwóch operatorów:
**=~** i **!~**, lewy operand jest napisem, a prawy wzorcem do dopasowania.
Wzorce są ciągami znaków otoczonymi znakami ograniczajacymi
(domyślnie **/**, ale można też użyć innego).

W kontekście logicznym operator **=~** zwraca prawdę, jeśli napis zawiera
wzorzec. **!~** jest zwykłą negacją tego operatora.
```perl
if ('this is a test' =~ /test/) {} # True
if ('this is a test' !~ /test/) {} # False
if ('this is Sparta' =~ /test/) {} # False
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

## Wzorce, a zmienne
Wzorce można zapisywać w zmiennych za pomocą operatora **qr**.

Wszystkie dopasowania poniżej są równoznaczne:
```perl
my $regex   = qr/abc/;
my $same_rx = qr(abc);
'abcdef' =~ /abc/;
'abcdef' =~ $regex;
'abcdef' =~ $same_rx;
```

W zakresie interpolacji, wzorce zachowują się jak podwójny cudzysłów,
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

## Metaznaki
Oprócz dosłownych znaków, wzorce mogą zawierać również metaznaki, które
opisują jakiś podzbiór wszystkich znaków, miejsce w napisie lub pozwalają
zdefiniować bardziej złożone wzorce.

### Klasy znaków
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

#### Klasy wbudowane
Kilka często używanych klas jest dostępnych jako znaki specjalne wewnątrz
wzorców:
* **\s** - znaki białe (spacje, taby, entery)
* **\S** - negacja **\s**, wszystkie niebiałe znaki
* **\d** - cyfry
* **\D** - wszystko oprócz cyfr
* **\w** - znaki _"słowne"_, wszystkie znaki alfanumeryczne i '\_'
* **\W** - negacja **\w**, znaki niealfanumeryczne
* **.**  - dowolny znak oprócz _"\n"_

### Miejsca w napisie
Kilka metaznaków dopasowuje miejsca w napisie zamiast zbioru liter, są to
dopasowania o zerowej długości.

#### Początek i koniec napisu
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

#### Brzeg słowa
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

## Krotność
Każdy element wzorca może mieć zdefiniowaną krotność. To znaczy, że do wzorca
można dopasować dowolną ilość wystąpień danego elementu. Krotność elementu
określa się przez dodanie do niego odpowiedniego kwantyfikatora.

### Zero lub jeden raz
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

### Raz lub więcej
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

### Dowolna ilość
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

### Przedział liczbowy
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

## Grupowanie i przechwytywanie
### Grupy elementów
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

### Przechwytywanie podnapisów
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

### Listy podnapisów
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

### Grupowanie bez przechwytywania
Jeśli nie chcemy zachowywać danej części tekstu, ale potrzebne jest grupowanie,
można na początek zawartości nawiasu dodać **?:**, wtedy będzie to wyłącznie
konstrukt grupujący, bez efektów ubocznych. Nie będzie się też liczył do
numerów zmiennych **$1**, **$2**, itd.

Dopasowanie wzorca _"a, od 2 do 5 sekwencji abc i trzy liczby"_,
bez przechwytywania:
```perl
m/a(?:abc){2,5}\d{3}/
```

## Alternatywa
Alternatywa pozwala nam dopasować dwa różne wzorce w jednym miescu. Metaznak
**|** oznacza, że w danym miescu może pasować i wzorzec po prawej
i wzorzec po lewej.
```perl
m/abc|def/;
```
Wzorzec powyżej będzie pasował do napisów:
```perl
'abc'
'def'
```
Po ludzku będzie znaczył _"napis 'abc' lub napis 'def'"_.

**UWAGA:** Alternatywa zawiera całość wzorca od znaku **|** do brzegu grupy lub
końca wyrażenia regularnego. Wyrażenia podanego w powyższym przykładzie nie
należy interpretować jako _"napis 'ab', litera 'c' lub litera 'd', napis
'ef'"_.

Alternatywy można łączyć w dopasowania więcej niż dwóch wzorców:
```perl
m/\AToday I ate (?:pasta|potatoes|rice)\Z/;
```

Powyższe wyrażenie dopasuje:
```
'Today I ate pasta'
'Today I ate potatoes'
'Today I ate rice'
```

## Chciwe i skąpe dopasowania
Kwantyfikatory **+** i __\*__ są _chciwe_. To znaczy, że dopasowują
najdłuższą część napisu, jaką się da. Nie zawsze jest to pożądane
zachowanie.

Załóżmy, że chcemy wyciągnąć z napisu tekst znajdujący się pomiędzy dwoma
cudzysłowami. Użycie dopasowania **.+** może wymknąć się spod kontroli
w następujym przypadku:
```perl
my $string = q(test "napis", "inny napis" i coś jeszcze);
my ($quote) = $string =~ /"(.+)"/;
say $quote;
```
Takie wyrażenie dopasuje najdłuższy możliwy ciąg znaków otoczony
cudzysłowami. Wynikiem powyższego programu jest:
```
napis", "inny napis
```

Dodanie znaku **?** po chciwym kwantyfikatorze zmieni jego tryb
dopasowania na skąpy. Dopasowanie skąpe dopasuje najkrótszy ciąg znaków
pasujący do wyrażenia. Skąpa wersja poprzedniego przykładu:
```perl
my $string = q(test "napis", "inny napis" i coś jeszcze);
my ($quote) = $string =~ /"(.+?)"/;
say $quote;
```
Wynik:
```
napis
```

## Modyfikatory dopasowań
Na końcu wyrażenia regularnego można dodawać modyfikatory, które zmieniają
zachowanie wyrażenia. Kilka bardziej przydatnych:

### /i
Modyfikator **/i** (case-**i**nsensitive) sprawia, że wielkość liter jest
ignorowana przy dopasowaniu.
```perl
print '1 Match' if 'TesT' =~ /test/;
print '2 Match' if 'TesT' =~ /test/i;
```
Wynik:
```
2 Match
```

### /s
Pod wpływem modyfikatora **/s** (**s**ingle-line) wyrażenie traktuje napis
jako pojedynczą linię, metaznak **.** dopasowuje wtedy również _"\n"_.
```perl
print '1 Match' if "Te\nst" =~ /.{5}/;
print '2 Match' if "Te\nst" =~ /.{5}/s;
```
Wynik:
```
2 Match
```

### /x
Modyfikator **/x** sprawia, że większość białych znaków wewnątrz wyrażenia
regularnego zostaje zignorowana. Pozwala to na rozbicie wyrażenia na mniejsze
części dla zwiększenia czytelności.
```perl
say '1 Match' if "Test" =~ /Test/;
say '2 Match' if "Test" =~ /Te      st/x;
```
Wynik:
```
1 Match
2 Match
```

## Quotemeta
Kiedy przyjmujemy wyrażenie regularne lub jego część jako wejście z
niekontrolowanego źródła (np. od użyszkodnika), należy uważać na znaki
specjalne. Do dosłownej interpretacji napisów wewnątrz wyrażeń służy funkcja
**quotemeta** i para metaznaków **\Q**, **\E**.

**quotemeta** przyjmuje napis jako argument i poprzedza wszystkie wystąpienia 
znaków niealfanumerycznych znakiem **\\**.
```perl
my $string = 'abc;-*_*a()[]';
say quotemeta $string;
```
Wynik:
```
abc\;\-\*_\*a\(\)\[\]
```

Interpolacja napisu przetworzonego przez **quotemeta** wewnątrz wyrażenia
regularnego spowoduje dopasowanie dosłownego napisu bez interpretacji znaków
specjalnych.

Metaznaki **\Q** i **\E** pozwalają kontrolować interpretację znaków
specjalnych wewnątrz wyrażeń regularnych. Od znaku **\Q** aż do znaku **\E**
wszytkie znaki wyrażenia będą interpretowane dosłownie.
```perl
my $string = '---[\d.+]---';
say 'Match 1' if $string =~ /-+[\d.+]-+/;
say 'Match 2' if $string =~ /-+\[\\d\.\+\]-+/;
say 'Match 3' if $string =~ /-+\Q[\d.+]\E-+/;
```
Wynik:
```
Match 2
Match 3
```

## Zamiana dopasowań
Składnia zamiany wygląda następująco:
```perl
s/old/new/
```
Znak **s/** przed wzorcem oznacza tryb zamiany. Po nim następuje wzorzec do
dopasowania i ciąg znaków, którym będzie zastąpiony. Na końcu mogą zostać
dodane modyfikatory, np. **/g**.
```perl
my $text = 'Lorem ipsum 617 if any 12 dwarves go home at 11:34.';
$text =~ s/\d+/<NUMBERS>/g;
say $text;
```
Wynik:
```
Lorem ipsum <NUMBERS> if any <NUMBERS> dwarves go home at <NUMBERS>:<NUMBERS>.
```

Wyrażenie zamiany zwraca ilość zamienionych dopasowań.
```perl
my $text = 'Lorem ipsum 617 if any 12 dwarves go home at 11:34.';
my $count = $text =~ s/\d+/<NUMBERS>/g;
say $count;
```
Wynik:
```
4
```

### Modyfikatory zamiany
Oprócz **/g**, istnieje kilka innych przydatnych modyfikatorów, które pozwalają
zmienić zachowanie wyrażenia regularnego.

#### /r
Modyfikator **/r** zmienia wartość zwracaną przez wyrażenie zamiany z liczby 
dopasowań na zmodyfikowaną kopię napisu. Pozwala to zachować początkowy
napis bez zmian.
```perl
my $text = '[name]: hue hue hue';
foreach my $name (qw(John Michael Tiffany Kate)) {
    say $text =~ s/\Q[name]\E/$name/r;
}
say $text;
```
Wynik:
```
John: hue hue hue
Michael: hue hue hue
Tiffany: hue hue hue
Kate: hue hue hue
[name]: hue hue hue
```

#### /e
Modyfikator **/e** pozwala podmieniać dopasowania na wynik działania funkcji
zamiast konkretnego napisu. Jeśli wykonujemy podmianę z tym modyfikatorem,
drugi operand operatora podmiany jest anonimową funkcją, podobnie jak
w przypadku **map**, **sort** i **grep**. Przy każdym dopasowaniu funkcja ta
zostanie wywołana, a dopasowanie zamienione na jej wynik. Dzięki temu możemy,
na przykład, w prosty sposób ponumerować wystąpienia wzorca:
```perl
my $text = 'test bla test bla Test';
my $counter = 0;
$text =~ s/(test)/"${1}[" . ++$counter . ']'/gei;
say $text;
```
Wynik:
```
test[1] bla test[2] bla Test[3]
```

## Nazwane grupy
Odwoływanie się do grup przez zmienne liczbowe (**$1**, **$2**...) może
być niewygodne w bardziej rozbudowanych wyrażeniach
(zwłaszcza zawierających alternatywy), dlatego Perl pozwala nam na 
tworzenie nazwanych grup, do których odwołujemy się po nazwie, a nie
numerze.

Nazwane grupy tworzy się przez dodanie na początku grupy konstrukcji
**?<nazwa>**. Zawartość takiej grupy nie trafi do zmiennej liczbowej,
za to będzie można się do niej odwołać przez specjalny hasz **%+**.
```perl
my $paren = "tekst [w nawiasie] i poza nawiasem";
if ($paren =~ /\[(?<paren>.+?)\]/) {
    print $+{paren};
}
```
Wynik:
```
w nawiasie
```

Wykorzystując nazwane grupy można znacznie zwiększyć czytelność kodu
odwołującego się do dopasowań.

## Sprawdzenia (assertions)
Wyrażenia regularne mają możliwość dopasowania wzorców w środowisku które
spełnia pewne warunki. Przykładami takich dopasowań są metaznaki
**\b**, **\A** i **\Z**. Sprawdzają czy wzorzec pojawił się na początku lub
końcu napisu lub na brzegu słowa.

W podobny sposób można sprawdzać obecność innych wzorców dookoła dopasowywanego
napisu.

Wyrażenie:
```perl
m/\bcat(?!astrophe)/;
```
dopasuje wyrazy zaczynające się od _"cat"_, gdzie po _"cat"_ nie
występuje słowo _"astrophe"_.

Taki wzorzec będzie pasował m. in. do:
```perl
'cat'
'catnip'
'catlog'
```
Ale nie do _"catastrophe"_.

**UWAGA:** Takie konstrukcje sprawdzające nie zabierają dopasowanej
części napisu. To znaczy, że jeśli wyciągniemy z napisu dopasowania,
to nie będą one zawierały sprawdzanej części:
```perl
my @cats = '1cat 2catnip 3catastrophe 4catlog' =~ m/\b\dcat(?!astrophe)/g;
say foreach @cats;
```
Wynik:
```
1cat
2cat
4cat
```

Sprawdzeń można używać do zawężania dopasowań wzorców. Np. jeśli chcemy
dopasować 4-literowy wyraz, ale nie lubimy testów:
```perl
my @words = 'test ball ground wind up help man test ban' =~ /\b(?!test)\w{4}\b/g;
say foreach @words;
```
Wynik:
```
ball
wind
help
```

Wszystkie sprawdzania działają w podobny sposób. Do wyboru mamy 4 rodzaje:
* (?!$regex) - sprawdź, czy $regex nie znajduje się z przodu
* (?=$regex) - sprawdź, czy $regex znajduje się z przodu
* (?<=$regex) - sprawdź, czy $regex znajduje się z tyłu
* (?<\!$regex) - sprawdź, czy $regex nie znajduje się z tyłu

**UWAGA:** Sprawdzenia do tyłu mogą zawierać tylko wzorce o stałej długości.
