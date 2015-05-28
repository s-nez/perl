# Warsztat 06

<!--TOC_START--->
## Spis treści
* [Parametry interpretera](#parametry-interpretera)
    * [Podawanie kodu na linii poleceń](#podawanie-kodu-na-linii-poleceń)
    * [Wczytywanie wejścia](#wczytywanie-wejścia)
    * [Autosplit](#autosplit)
    * [Więcej opcji](#więcej-opcji)
* [Bloki BEGIN i END](#bloki-begin-i-end)
* [CPAN](#cpan)
    * [Konfiguracja cpanminus](#konfiguracja-cpanminus)
    * [Instalacja](#instalacja)
    * [Lokalne repozytorium modułów](#lokalne-repozytorium-modułów)

<!--TOC_END--->

## Parametry interpretera
Interpreter Perla można wywoływać z dodatkowymi parametrami, które
pozwalają podawać kod bezpośrednio z linii poleceń i dodawać
często używane przydatne konstrukcje.

Pozwala to w łatwy sposób pisać krótkie, jednolinijkowe programy.

### Podawanie kodu na linii poleceń
Opcje **-e** i **-E** przyjmują kod programu jako argument napisowy.

Program "Hello World" przy wykorzystaniu parametrów interpretera:
```
perl -e 'print "Hello World\n"';
```

Opcja **-E** działa dokładnie tak samo, ale włącza dodatkowo wszystkie
opcjonalne funkcjonalności języka (np. **say**).

Powyższy "Hello World" można więc zapisać tak:
```perl
perl -E 'say "Hello World"';
```

**UWAGA:** Wiele powłok używa **$** do oznaczania zmiennych, tak samo jak
Perl. Dlatego, żeby uninkąć usunięcia wszystkich użytych zmiennych z
programu, argumenty **-e** należy brać w pojedynczy cudzysłów.

### Wczytywanie wejścia
Opcja **-n** otoczy program pętlą wczytujacą wejście:
```perl
while (<>) {
    # tutaj program
}
```
Wywołanie:
```
perl -ne 'print if length > 3';
```

Jest równoznaczne z wykonaniem następującego programu:
```perl
while (<>) {
    print if length > 3;
}
```

Dodatkowo można też wypisać zawartość domyślnej zmiennej **$_** używająć
zamiast **-n** opcji **-p**. Jest to rozszerzona wersja **-n**, która
otacza kod następującą konstrukcją:
```perl
while (<>) {
    # tutaj program
} continue {
    print or die "-p destination: $!\n";
}
```
Blok **continue** wykonuje się po każdej iteracji **while**, nawet jeśli
została zakończona przez **next**. Jak można zauważyć w kodzie, błąd
wypisywania kończy program.

Korzystając z własności zmiennej domyślnej możemy pisać bardzo zwięzłe
programy na linii poleceń. Na przykład, program, który zamienia wszystkie
wystąpienia hasła 'hunter2' na ciąg '\*\*\*\*\*\*\*':
```
perl -pe 's/hunter2/*******/g'
```
Dzięki właściwości operatora **<>**, takiego programu możemy użyć bezpośrednio
na standardowym wejściu lub na plikach. Argumenty programu podaje się po
kodzie:
```
perl -E 'say for @ARGV' arg1 arg2 arg3
```
Wynik:
```
arg1
arg2
arg3
```

### Autosplit
Dodanie opcji **-a** do **-n** lub **-p** właczy automatyczny **split** na
wejściu.  Wynik funkcji **split** zostaje umieszczony w tablicy **@F**.

Wywołanie:
```
perl -ane '...'
```
Jest odpowiednikiem:
```perl
while (<>) {
    @F = split;
    ...
}
```

Domyślnie **split** używa białych znaków jako separatora. Separator można
zmienić za pomocą opcji **-F**.

Wypisanie nazw zwykłych użytkowników z /etc/passwd:
```
perl -F: -ane 'print $F[0] if 1000 <= $F[2] and $F[2] <= 60000' /etc/passwd
```

### Więcej opcji
Wszystkie parametry interpretera są opisane w:
```
perldoc perlrun
```

## Bloki BEGIN i END
Bloki **BEGIN** i **END** są wykonywane tylko raz, na początku lub na końcu
programu, niezależnie do tego, w którym miejscu programu sie znajdują.
```perl
END { say 'Finish'; }
print foreach 1 .. 10;
print "\n";
BEGIN { say 'Start'; }
```
Wynik:
```
Start
12345678910
Finish
```

**UWGA:** Jeśli blok **END** zawiera odwołania do zmiennych, to muszę one być
w zakresie bloku i istnieć w momencie zakończenia programu.

Bloki **BEGIN** i **END** są przydatne przy pisaniu jednolinijkowych programów
z dodanymi pętlami (**-p** i **-n**). Mimo, że program zawiera się
w pętli, dzięki blokom **BEGIN** i **END** możemy wykonać jakieś operacje
jednorazowo na początku programu.

Program, który zainicjalizuje licznik na 100 i odejmie od niego wszystkie
liczby całkowite znalezione na wejściu, a na koniec wypisze stan licznika:
```
perl -nE 'BEGIN { $c = 100 } $c -= $_ for (/(\d+)/g); END { say $c, " left" }'
```
Przykładowe wejście:
```
test
nic
40
10 oraz 15
koniec
```
Wynik dla podanego wejścia:
```
35 left
```

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

### Konfiguracja cpanminus
Jednym z prostszych w obsłudze klientów do CPANu jest
[cpanminus](https://metacpan.org/pod/App::cpanminus). Pozwala automatycznie
pobierać, rozpakowywać i instalować moduły razem z zależnościami.

### Instalacja
cpanminus znajduje się w repozytoriach większości dystrybucji:
* Fedora, openSUSE: perl-App-cpanminus
* Ubuntu, Debian, Arch: cpanminus

### Lokalne repozytorium modułów
cpanminus nie powinno się używać do globalnej instalacji modułów. Dlatego
lepiej jest stworzyć lokalne repozytorium w swoim katalogu domowym.

Na początek należy stworzyć katalog, w którym będziemy trzymać repozytorium,
np. **~/.perl**. Potem możemy użyć cpanminus do skonfigurowania repozytorium:
```
cpanm --local-lib=~/.perl local::lib && eval $(perl -I ~/.perl/lib/perl5/ -Mlocal::lib)
```

Żeby Perl uwzględnił nowopowstałe repozytorium przy szukaniu modułów, do
zmiennej środowiskowej **PERLLIB** należy dodać jego lokalizację.
```bash
PERLLIB=$HOME/.perl/lib/perl5
export PERLLIB=$PERLLIB:$PERLLIB/x86_64-linux-thread-multi
```
Druga część zmiennej jest potrzebna, jeśli instalujemy moduły, które
korzystają z wielowątkowości. Żeby zmiana została utrwalona,
modyfikację zmiennej należy umieścić w skrypcie inicjalizacyjnym powłoki
(w przypadku Basha - **~/bashrc**).

Przy instalacji modułu za każdym razem trzeba podawać ścieżkę do lokalnego
repozytorium. Na przykład, żeby zainstalować moduł
[Reddit::Client](https://metacpan.org/pod/Reddit::Client):
```
cpanm --local-lib=~/.perl Reddit::Client
```

Możemy ułatwić sobie życie i uniknąć literówek dodając alias, np.:
```bash
alias cpan-install='cpanm --local-lib=~/.perl'
```

Wtedy moduły możemy instalować w dużo prostszy sposób:
```
cpan-install Reddit::Client
```
