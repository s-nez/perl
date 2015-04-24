# Przydatne konstrukcje językowe
## Iterowanie po tablicy, ze świadomością indeksu
Funkcja **keys** zwraca listę indeksów tablicy:
````perl
my @array = ("abc", "def", "ghi");
foreach my $index (keys @array) {
    say "$index: $array[$index]";
}
````
Generator **each** zwraca pary (dwuelementowe listy) - (indeks, wartość):
````perl
while (my ($index, $value) = each @array) {
    say "$index: $value";
}
````
Wyjście:
````
0: abc
1: def
2: ghi
````

## Pętla "wykonaj n razy"
````perl
my $n = 3;
for (1 .. $n) {
    print "hue ";
}
````
Wyjście:
````
hue hue hue 
````

## Zwróć błąd, jeśli nie podano argumentów do programu
Operator **or** zacznie rozważać drugi operand tylko jeśli pierwszy jest 
fałszem, pozwala nam to na grożenie programowi:
````perl
@ARGV or die 'No arguments';
````
