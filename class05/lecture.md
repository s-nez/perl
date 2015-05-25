# Warsztat 05

<!--TOC_START--->
## Spis treści
* [Wyrażenia regularne - ciąg dalszy](#wyrażenia-regularne---ciąg-dalszy)
    * [Alternatywa](#alternatywa)
    * [Chciwe i skąpe dopasowania](#chciwe-i-skąpe-dopasowania)
    * [Modyfikatory dopasowań](#modyfikatory-dopasowań)
        * [/i](#i)
        * [/s](#s)
        * [/x](#x)
    * [Quotemeta](#quotemeta)
    * [Zamiana dopasowań](#zamiana-dopasowań)
        * [Modyfikatory zamiany](#modyfikatory-zamiany)
    * [Nazwane grupy](#nazwane-grupy)
    * [Sprawdzenia (assertions)](#sprawdzenia-assertions)
* [Funkcje ze stanem](#funkcje-ze-stanem)
* [Anonimowe funkcje](#anonimowe-funkcje)
* [Dispatch table](#dispatch-table)

<!--TOC_END--->

## Wyrażenia regularne - ciąg dalszy
### Alternatywa
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

### Chciwe i skąpe dopasowania
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

### Modyfikatory dopasowań
Na końcu wyrażenia regularnego można dodawać modyfikatory, które zmieniają
zachowanie wyrażenia. Kilka bardziej przydatnych:

#### /i
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

#### /s
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

#### /x
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

### Quotemeta
Kiedy przyjmujemy wyrażenie regularne lub jego część jako wejście z
niekontrolowanego źródła (np. od użyszkodnika), należy uważać na znaki
specjalne. Do dosłownej interpretacji napisów wewnątrz wyrażeń służy funkcja
**quotemeta** i para metaznaków **\Q**, **\E**.

**quotemeta** przyjmuje napis jako argument i poprzedza wszystkie wystąpienia 
znaków niealfanumerycznych znakiem **\**.
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

### Zamiana dopasowań
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

#### Modyfikatory zamiany
Oprócz **/g**, istnieje kilka innych przydatnych modyfikatorów, które pozwalają
zmienić zachowanie wyrażenia regularnego.

##### /r
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

##### /e
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

### Nazwane grupy
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

### Sprawdzenia (assertions)
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

## Funkcje ze stanem
Zmienne stanowe wewnątrz funkcji zachowują się jak zmienne lokalne (są widoczne
tylko wewnątrz funkcji), ale inicjalizowane są tylko raz i zachowują swoją
wartość pomiędzy wywołaniami funkcji. Do deklaracji zmiennych stanowych używa
się słowa kluczowego **state**.
```perl
sub counter {
    state $count = 0;
    return $count++;
}
say counter() for 1..3;
```
Wynik:
```
0
1
2
```
**state** deklaruje zmienną, więc nie należy dodawać do deklaracji słowa
kluczowego **my**.

**UWAGA:** Żeby użyć zmiennych stanowych do programu trzeba dodać:
```perl
use feature 'state';
```
lub
```
use v5.10;
```
ewentualnie wyższą wersję.

## Anonimowe funkcje
Anonimowa funkcja jest funkcją bez nazwy, do której można się odwołać przez
referencję. Zasada tworzenia i odwołania jest taka sama jak przy anonimowych
zmiennych. Aby stworzyć anonimową funkcję, używamy bloku **sub** bez nazwy:
```perl
my $add = sub { $_[0] + $_[1] };
```
Odwołanie do funkcji wskazywanej przez skalar odbywa sie za pomocą operatora
**->**.
```perl
print $add->(2, 3);
```

Wynik:
```
5
```

## Dispatch table
Dispatch table jest idiomem Perla, który wykorzystując hasz anonimowych
funkcji przyporządkowuje wejście do zachowania. Idiom ten ma wiele
zastosowań, jednym z bardziej popularnych jest przetwarzanie wejścia
o rozbudowanym formacie.

Ogólna struktura dispatch table do przetwarzania wejścia:
```perl
my $state = 'start';
my %parser = (
    start => sub { ... },
    state0 => sub { ... },
    state1 => sub { ... },
);
```
Klucze hasza **%parser** odpowiadają stanom przetwarzania. Na przykład,
jeśli chcemy wyszukać jakąś wartość na wejściu, a po znalezieniu jej
wykonywać na pozostałej części jakąś inną czynność, stanami mogły
by być _'start'_, _'not\_found'_ i _'found'_.

Główna pętla przetwarzająca wejście z wykorzystaniem takiego parsera:
```perl
until (eof) {
    my $line = <>;
    $parser{$state}->($line);
}
```

Załóżmy, że chcemy przetworzyć plik w następującym formacie:
```
<a>
123-123
456-789
</a>

<b>
234-765
103-567
123-098
333-111
</b>
<a>
111-222
333-444
</a>
```
W pliku pojawiają się dwa rodzaje sekcji: **a** i **b**, w każdej z nich
znajdują się linie wejścia w identycznym formacie. W zależności od tego,
w której sekcji znajdują się dane, chcemy umieścić dane w tablicy **@A**
lub w tablicy **@B**.

Tworzenie parsera rozpoczynamy od zdefiniowania potrzebnych stanów. W tym
przykładzie będą nam potrzebne 3 stany:
* poza znacznikami (start)
* wewnątrz znacznika **a** (in\_a)
* wewnątrz znacznika **b** (in\_b)

Stan start będzie się zajmował tylko i wyłącznie szukaniem znaczników
startowych.
```perl
start => sub {
    my $line = shift;
    if ($line eq '<a>') {
        $state = 'in_a';
    } elsif ($line eq '<b>') {
        $state = 'in_b';
    }
}
```

Stany 'in\_a' i 'in\_b' działają pod założeniem, że znajdujemy się wewnątrz
odpowiedniego znacznika. Powinny więc zajmować się swoją sekcją wejścia i
sprawdzać, czy nie trafiliśmy na znacznik końcowy.
```perl
in_a => sub {
    my $line = shift;
    if ($line eq '</a>') { # trafiliśmy na znacznik końca
        $state = 'start';  # przechodzimy z powrotem do stanu 'start'
    } else {
        push @A, $line;
    }
}
```
Stan 'in\_b' będzie wyglądał analogicznie.

Podczas pisania parserów na podstawie dispatch table warto dodać do głównej
pętli następującą linijkę:
```perl
print "$state: $line";
```
Dzięki temu łatwo będzie określić, czy przejścia między stanami zostały
wykonane poprawnie i który stan przetwarzał którą linijkę.

Pełny program:
```perl
my (@A, @B);
my $state = 'start';
my %parser = (
    start => sub {
        my $line = shift;
        if ($line eq '<a>') {
            $state = 'in_a';
        } elsif ($line eq '<b>') {
            $state = 'in_b';
        }
    },
    in_a => sub {
        my $line = shift;
        if ($line eq '</a>') {    # trafiliśmy na znacznik końca
            $state = 'start';     # przechodzimy z powrotem do stanu 'start'
        } else {
            push @A, $line;
        }
    },
    in_b => sub {
        my $line = shift;
        if ($line eq '</b>') {    # trafiliśmy na znacznik końca
            $state = 'start';     # przechodzimy z powrotem do stanu 'start'
        } else {
            push @B, $line;
        }
    }
);

until (eof) {
    my $line = <>;
    print "$state: $line";
    chomp $line;
    $parser{$state}->($line);
}

print "\n";
say '@A:';
say foreach @A;

print "\n";
say '@B:';
say foreach @B;
```

Dostając na wejście przykładowe dane podane wyżej, program wypisze:
```
start: <a>
in_a: 123-123
in_a: 456-789
in_a: </a>
start: 
start: <b>
in_b: 234-765
in_b: 103-567
in_b: 123-098
in_b: 333-111
in_b: </b>
start: <a>
in_a: 111-222
in_a: 333-444
in_a: </a>

@A:
123-123
456-789
111-222
333-444

@B:
234-765
103-567
123-098
333-111
```

Przetwarzanie wejścia w ten sposób pozwala nam podzielić problem na mniejsze
podproblemy i znacznie upraszcza cały proces.
