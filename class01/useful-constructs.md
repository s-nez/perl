# Przydatne konstrukcje językowe

## Pętla "wykonaj n razy"
```perl
my $n = 3;
for (1 .. $n) {
    print "hue ";
}
```
Wyjście:
```
hue hue hue 
```

## Zwróć błąd, jeśli nie podano argumentów do programu
Operator **or** zacznie rozważać drugi operand tylko jeśli pierwszy jest 
fałszem, pozwala nam to na grożenie programowi:
```perl
@ARGV or die 'No arguments';
```

## Sprawdź, czy podano konkretną liczbę argumentów
Zwróć błąd, jeśli nie podano równo 3 argumentów:
```perl
die "Invalid number of arguments\n" unless @ARGV == 3;
```
