# Quiz
Napisz prosty quiz. Wczytaj pytania i odpowiedzi z pliku
[ex04-quiz.input](https://github.com/slimakuj/perl/blob/legacy_2016/class03/exercises/ex04-quiz.input).
Program może zakładać pełną poprawność danych wejściowych.

Program powinien przyjąć jeden lub dwa argumenty:
```
./prog.pl ex04-quiz.input 4
```
Pierwszy argument to nazwa pliku z pytaniami, drugi to liczba pytań, które
mają być zadane użytkownikowi. Jeśli drugi argument nie zostanie podany,
należy przyjąć liczbę 3 jako ilość pytań.

Po wczytaniu danych program powinien wylosować z zestawu odpowiednią liczbę
pytań i po kolei zadać je użytkownikowi, informując na bieżąco o prawidłowości
odpowiedzi. Po zadaniu wszystkich pytań, program powinien wyświetlić
podsumowanie:
```
Twój wynik: [liczba poprawnych odpowiedzi]/[liczba pytań]
```

## Przykładowe wejście i wyjście
Argumenty programu:
```
./prog.pl ex04-quiz.input 3
```
Wyjście programu z wejściem użytkownika:
```
Ile to jest 2+2?

A) 4
B) 3
C) 5
D) Jakie są założenia?
Odpowiedź: C
Błędna odpowiedź

Która z poniższych nie jest klasą postaci w Tales of Maj'Eyal?

A) Knight
B) Mindslayer
C) Paradox Mage
D) Berserker
Odpowiedź: A
Poprawna odpowiedź!

Jaka jest odpowiedź na wszystkie pytania wszechświata i sens istnienia?

A) Matematyka
B) Undef
C) 42
D) Jednorożce
Odpowiedź: D
Błędna odpowiedź

Twój wynik: 1/3
```
