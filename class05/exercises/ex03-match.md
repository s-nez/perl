# Dopasowanie
Pobierz plik
[ex03-match-form.pl](https://github.com/SlimakUJ/perl/blob/master/class05/exercises/ex03-match-form.pl).
Uzupełnij deklaracje zmiennych w początkowej sekcji pliku odpowiednimi
wzorcami.

## $nostart\_comment
Dopasuj napis, który zawiera jednoliniowy komentarz w stylu Perla (#) lub
w stylu C++ (//), ale nie na początku napisu.

Przykładowe prawidłowe dopasowania:
```
'code much code # and comment',
'other // style',
```

Przykładowe  błędne dopasowanie:
```
'#comment'
```

## $not\_evil\_nums
Dopasuj napis, który jest liczbą całkowitą, która ma conajmniej 6 cyfr, ale
nie kończy się sekwencją 666.

## $read\_frame
Dopasuj napis, który jest prawidłową ramką odczytu mRNA, to znaczy składa się
z trójek liter A, U, C i G, zaczyna się sekwencją START, czyli _"AUG"_, a
kończy jedną z sekwencji STOP: _"UAG"_, _"UGA"_ lub _"UAA"_. Wewnątrz ramki
może występować dowolna ilość sekwencji START, ale nie może pojawić się żadna
sekwencja STOP (taka może być tylko na końcu).
