# Jednolinijkowce
Dla każdego polecenia napisz jednolinijkowy program, który je wykona
program powinien składać się tylko z wywołania interpetera,
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

## Skracanie linii
Wypisz linie wejścia lub pliku. Jeśli linia ma więcej niż 40 znaków,
skróć ją do 40 (odetnij resztę) i zastąp osttanie 3 znaki kropkami.

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
