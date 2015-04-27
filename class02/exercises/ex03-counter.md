# Liczenie słów
Wczytuj standardowe wejście lub plik podany jako argument programu aż do
EOF i policz wystąpienia każdego słowa, które pojawi sie na wejściu. Słowo
definiujemy jako ciąg znaków oddzielony spacjami.

## Przykładowe wejście i wyjście
Wejście:
````
dowód tautologia aksjomat
aksjomat
autor traktor
dowód autora na tautologię traktora
grunt byle autor nie traktor
to dowód
````

Wyjście:
````
tautologię: 1
traktora: 1
nie: 1
grunt: 1
autora: 1
autor: 2
na: 1
aksjomat: 2
tautologia: 1
traktor: 2
byle: 1
to: 1
dowód: 3
````
