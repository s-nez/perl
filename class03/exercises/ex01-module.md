# Moduł

Stwórz moduł **File::Count**, który będzie dostarczał następujące funkcje:
* words([PLIK]) - zwraca liczbę słów w pliku PLIK;
* lines([PLIK]) - zwraca liczbę linii w pliku PLIK;
* chars([PLIK]) - zwraca liczbę znaków w pliku PLIK;

Wszystkie funkcje przyjmują ścieżke do pliku jako argument.

Używając tego modułu, napisz skrypt, który przyjmie jako argumenty
przełącznik trybu i nazwę pliku, a następnie policzy słowa, linie lub znaki
w tym pliku.

Tryby:
* -l - linie
* -w - słowa
* -c - znaki

Wywołanie programu liczęce znaki:
```
$ perl wc.pl -c ex01-module.input
```

Właściwości przykładowego pliku [ex01-module.input](https://github.com/slimakuj/perl/blob/master/class03/exercises/ex01-module.input):
* 6 linii
* 59 słów
* 397 znaków 
