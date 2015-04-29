# WC
Napisz prostę wersję programu
[wc](https://en.wikipedia.org/wiki/Wc_%28Unix%29), który będzie liczył linie,
słowa lub znaki na standardowym wejściu lub w plikach.

Program będzie uruchamiany w następujący sposób:
````
./prog.pl -[wlc] [plik]
````
Pierwszym argumentem może być jeden z trzech napisów, będzie on oznaczał tryb
działania programu:
* \-w \- licz słowa
* \-l \- licz linie
* \-c \- licz znaki (wliczając w to znaki białe)

Drugi argument jest opcjonalny, jeśli zostanie podany, jest to nazwa pliku, w
którym mamy liczyć słowa, znaki lub linie. Jeśli nie zostanie podany, należy
zamiast niego wczytać standardowe wejście.

## Przykładowe wejście i wyjście
Dla pliku o następującej zawartości (plik [sample.input](https://github.com/slimakuj/perl/blob/devel/class02/exercises/sample.input)):
````
dowód tautologia aksjomat
aksjomat
autor traktor
dowód autora na tautologię traktora
grunt byle autor nie traktor
to dowód
````

W trybie **\-l** należy wypisać:
````
Total: 6 lines
````
W trybie **\-w**:
````
Total: 18 words
````
W trybie **\-c**:
````
Total: 127 characters
````

Jeśli pierwszy argument nie zostanie podany lub nie odpowiada żadnemu trybowi,
należy wypisać:
````
Invalid mode
````
