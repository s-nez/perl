# Warsztat 05

<!--TOC_START--->
## Spis treści
* [Parametry interpretera](#parametry-interpretera)
    * [Podawanie kodu na linii poleceń](#podawanie-kodu-na-linii-poleceń)
    * [Wczytywanie wejścia](#wczytywanie-wejścia)
    * [Autosplit](#autosplit)
    * [Edycja w miejscu](#edycja-w-miejscu)
    * [Więcej opcji](#więcej-opcji)
* [Bloki BEGIN i END](#bloki-begin-i-end)
* [Referencje do funkcji](#referencje-do-funkcji)
    * [Anonimowe funkcje](#anonimowe-funkcje)
    * [Referencje do nazwanych funkcji](#referencje-do-nazwanych-funkcji)

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
$ perl -e 'print "Hello World\n"';
```

Opcja **-E** działa dokładnie tak samo, ale włącza dodatkowo wszystkie
opcjonalne funkcjonalności języka (np. **say**).

Powyższy "Hello World" można więc zapisać tak:
```perl
$ perl -E 'say "Hello World"';
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
$ perl -ne 'print if length > 3';
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
$ perl -pe 's/hunter2/*******/g'
```
Dzięki właściwości operatora **<>**, takiego programu możemy użyć bezpośrednio
na standardowym wejściu lub na plikach. Argumenty programu podaje się po
kodzie:
```
$ perl -E 'say for @ARGV' arg1 arg2 arg3
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
$ perl -ane '...'
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

### Edycja w miejscu

Parametr **-i** włącza tryb edycji w miejcu. Pozwala to modyfikować pliki
będące argumentami programu.

Przykład:
```
$ perl -i -ple 's/foo/bar/g' file.txt
```
Powyższe wywołanie zamieni wszystkie wystąpienia słowa **foo** na **bar**
w pliku file.txt (plik zostanie zmodyfikowany).

Jeśli użyjemy **-i** bez argumentów, oryginalna zawartość pliku zostanie
utracona. Można ją zachować, dodając rozszerzenie jako argument **-i**:
```
$ perl -i.orig -ple 's/foo/bar/g' file.txt
```
Teraz plik file.txt zostanie zmodyfikowany, ale jego aryginalna zawartość
zostanie zachowana w pliku "file.txt.orig". Jest to dobre zabezpieczenie
na wypadek pomyłki.

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

**UWGA:** Jeśli blok **END** zawiera odwołania do zmiennych, to muszą one być
w zakresie bloku i istnieć w momencie zakończenia programu.

Bloki **BEGIN** i **END** są przydatne przy pisaniu jednolinijkowych programów
z dodanymi pętlami (**-p** i **-n**). Mimo, że program zawiera się
w pętli, dzięki blokom **BEGIN** i **END** możemy wykonać jakieś operacje
jednorazowo na początku lub końcu programu.

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

## Referencje do funkcji

### Anonimowe funkcje
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

### Referencje do nazwanych funkcji
Referencję do nazwanej funkcji, tak jak w przypadku zmeinnych, można uzyskać
operatorem \\. Do nazwy funkcji trzeba dodać znak **&**, jest to oznaczenie
funkcji, tak samo jak **$** oznacza skalar, a **@** tablicę.
```perl
sub do_something { ... }

my $coderef = \&do_something;
$coderef->(); # == do_something()
```

Z tak uzyskaną referencją można pracować dokładnie tak samo jak z referencją
do anonimowej funkcji.
