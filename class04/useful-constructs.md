# Przydatne konstrukcje
## Wypisywanie zawartości pliku z numerowaniem linii
Zmienna $. zawiera numer linii w ostatnim odczytanym uchwycie do pliku.
````perl
open my $FH, '<', $filename;
while (<$FH>) {
    print "$.: $_";
}
close $FH;
````

Zawartość pliku można też czytać wewnątrz pętli:
````perl
open my $FH, '<', $filename;
while (not eof $FH) {
    print $., ': ',  scalar <$FH>;
}
close $FH;
````
