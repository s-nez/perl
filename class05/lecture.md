# Warsztat 05

<!--TOC_START--->
## Spis treści
* [Funkcje ze stanem](#funkcje-ze-stanem)
* [Anonimowe funkcje](#anonimowe-funkcje)
* [Dispatch table](#dispatch-table)

<!--TOC_END--->

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
