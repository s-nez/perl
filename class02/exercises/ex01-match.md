# Dopasowanie
Pobierz plik
[ex01-match-form.pl](https://github.com/SlimakUJ/perl/blob/master/class02/exercises/ex01-match-form.pl).
Uzupełnij deklaracje zmiennych w początkowej sekcji pliku odpowiednimi
wzorcami.

## $blank
Dopasuj napis pusty lub składający się wyłącznie ze znaków białych.

## $integer
Dopasuj napis, który jest liczbą całkowitą, tzn. ciąg cyfr bez innych znaków.
Jedynym wyjątkiem jest znak "\n" na końcu.

## $float
Dopasuj napis, który jest liczbą zmiennoprzecinkową, czyli ciąg cyfr, który
dodatkowo może mieć kropkę w środku. Tak samo jak $integer, $float też powinien
dopasować liczbę z enterem na końcu.

## $phone\_number
Dopasuj numer telefonu w formacie:
```
CCC-CCC-CCC
```
gdzie C jest cyfrą od 0 do 9.

## $sentence
Dopasuj napis, który jest zdaniem, tzn. ciągiem wyrazów oddzielonych
spacjami i kończącym się kropką lub znakiem zapytania. Zdanie jest
prymitywne i nie może zawierać znaków interpunkcyjnych (oprócz kropki lub 
znaku zapytania na końcu), nie musi się też zaczynać dużą literą.

## $five\_l\_word
Dopasuj napis, który zawiera słowo, które ma dokładnie 5 liter

## $dialog\_three
Dopasuj napis, który zaczyna się słowem z dwukropkiem, po którym następują
trzy identyczne wyrazy, np.
```
Person: hue hue hue
```
Po takim dialogu może znajdować się dowolny ciąg znaków.

## $web\_address
Dopasuj adres strony internetowej. Może, ale nie musi zaczynać się od "http://"
lub "https://". Przedrostek "www." również jest opcjonalny.

Przykładowe dopasowania:
```
http://www.strona.com
https://www.page.co.uk
www.test.ru
uj.edu.pl
http://fsf.org
```

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
Dopasuj napis, który jest liczbą całkowitą, która ma co najmniej 6 cyfr, ale
nie kończy się sekwencją 666.

## $read\_frame
Dopasuj napis, który jest prawidłową ramką odczytu mRNA, to znaczy składa się
z trójek liter A, U, C i G, zaczyna się sekwencją START, czyli _"AUG"_, a
kończy jedną z sekwencji STOP: _"UAG"_, _"UGA"_ lub _"UAA"_. Wewnątrz ramki
może występować dowolna ilość sekwencji START, ale nie może pojawić się żadna
sekwencja STOP (taka może być tylko na końcu).
