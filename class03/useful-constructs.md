# Przydatne konstrukcje
## Losowanie n liczb bez powtórzeń
````perl
my $n = 3;
my %random;
while (keys %random < $n) {
    undef $random{int rand 10};
}
keys %random; # tablica trzech losowych liczb bez powtórzeń
````
Klucze w haszu nie mogą się powtarzać, więc jeśli wylosujemy liczbę, która
już została wylosowana wcześniej, nie powstanie nowy klucz. Dzięki temu
możemy losować po prostu nowe wartości aż liczba kluczy nie dojdzie
do wymaganej wartości.

Interesują nas tylko klucze, więc zamiast używania **undef** można
by przypisywać dowolną wartość z tym samym efektem. Użycie **undef**
jest po prostu szybszym sposobem na stworzenie klucza niż przypisanie.

## Wczytanie kilku kolejnych linii wejścia do różnych zmiennych
````perl
my ($first, $second, $third);
$_ = <> foreach ($first, $second, $third);
````
**$\_** w pętli **foreach** jest aliasem do zmiennej, więc operacje na niej
mają taki sam efekt, jak operacje na samej zmiennej. Złożenie listy ze
skalarów w ten sposób pozwala prosto wczytać 3 linie wejścia kolejno
do zmiennych **$first**, **$second** i **$third**.

## Odrzucenie początkowej części napisu o określonym formacie
````perl
my $string = 'X: Actually important stuff';
my (undef, $ai_stuff) = split ': ', $string;
$ai_stuff; # 'Actually important stuff'
````

## Sortowanie według dwóch różnych cech
Sortowanie według długości, a w przypadku napisów równej długości -
leksykograficznie:
````perl
sort { (length $a <=> length $b) or ($a cmp $b) } @strings;
````
Dzięki temu, że komparatory używane do sortowania zwracają 0 w przypadku
równości, możemy wykorzystać fakt, że 0 to fałsz w kontekście logicznym
i użyć operatora **or** do podania drugorzędnego komparatora.
