# Jednolinijkowce
Dla każdego polecenia napisz jednolinijkowy program, który je wykona.
Program powinien składać się tylko z wywołania interpetera,
a całość nie może być dłuższa niż 80 znaków. Argumenty programu
(nie interpetera) nie liczą się do limitu.

## Liczenie linii
Policz linie w pliku lub standardowym wejściu. Program powinien działać
tak samo jak **wc -l**.

## Najdłuższa linia
Wypisz długość najdłuższej linii wejścia lub pliku, nie licząc znaku
nowej linii, tak jak **wc - L**.

## Numerowanie wejścia
Ponumeruj linie wejścia lub pliku, podobnie jak **cat -n**, ale bez
wcięcia na początku.

### Przykładowe wejście i wyjście
Wejście:
```
test
linia
inna linia
hue
```

Wynik:
```
1  test
2  linia
3  inna linia
4  hue
```

## Składanie argumentów
Wczytuj wejście lub plik linia po linii, każdą linię słów oddzielonych
białymi znakami zamień na listę argumentów napisowych.

### Przykładowe wejśce i wyjście
Wejście:
```
one two three
hue hue 
test

test more test
```

Wyjście:
```
('one', 'two', 'three')
('hue', 'hue')
('test')
('')
('test', 'more', 'test')
```

## Skracanie linii
Wypisz linie wejścia lub pliku. Jeśli linia ma więcej niż 40 znaków,
skróć ją do 40 (odetnij resztę) i zastąp ostatnie 3 znaki kropkami.

### Przykładowe wejśce i wyjście
Wejście:
```
hue
short
also short
loooooooooooooooooooooooooooooooooooooooooooooooong
limit ------------------------------ END
test very long and stuff long long long long
```
Wynik:
```
hue
short
also short
loooooooooooooooooooooooooooooooooooo...
limit ------------------------------ ...
test very long and stuff long long lo...
```

## Zmiana nazw plików
Napisz program, który przyjmuje wejście z **ls -1** i zmienia nazwy wszystkich
plików w formacie:
```
[napis][liczba]
```
na:
```
[liczba]-[napis]
```
Przykładowa zawartość katalogu:
```
test01  test04  test07  test11  test14  test17  test20  testc  testf
test02  test05  test08  test12  test15  test18  testa   testd
test03  test06  test09  test13  test16  test19  testb   teste
```
Wywołanie programu:
```
ls -1 | perl [parametry]
```
Zawartość katalogu po wykonaniu programu:
```
01-test  04-test  07-test  11-test  14-test  17-test  20-test  testc  testf
02-test  05-test  08-test  12-test  15-test  18-test  testa    testd
03-test  06-test  09-test  13-test  16-test  19-test  testb    teste
```

Zawartość przykładowego katalogu można wygenerować poleceniem:
```
perl -e 'open $F, ">", "test$_" for 11 .. 20, a .. f, map { "0" . $_ } 1 .. 9'
```
