# Warsztat 06
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
opcjonalne funkcjonalności języka (np. **say**). Jest odpowiednikiem
dodania na początek programu (w Perlu 5.20):
```perl
use v5.20;
```

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
