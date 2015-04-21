# Warsztat 02

<!--TOC_START--->
## Spis treści
* [Operacje na plikach](#operacje-na-plikach)
    * [Uchwyty](#uchwyty)
    * [Odczytywanie plików](#odczytywanie-plików)
    * [Zapisywanie plików](#zapisywanie-plików)
        * [Dopisywanie danych do pliku](#dopisywanie-danych-do-pliku)
        * [Domyślny uchwyt wyjściowy](#domyślny-uchwyt-wyjściowy)

<!--TOC_END--->

## Operacje na plikach
### Uchwyty
Zanim zaczniemy pracę z plikiem, należy go otworzyć. Załóżmy, że chcemy
odczytać plik o nazwie "plik.md":
````perl
open my $FH, '<', 'plik.md';
````
Funkcja **open** przyjmuje trzy argumenty:
* zmienną, która będzie uchwytem do pliku
* tryb operacji na pliku
* nazwę pliku

**UWAGA**: Otwarcie pliku może się nie powieść (plik nie istnieje, nie mamy do
niego dostępu, itp.), **open** zwraca fałsz i ustawia specjalną zmienną **$!**,
zawierającą ostatni błąd, jeśli otwarcie pliku się nie powiedzie. Pozwala to na
wykrycie błędu otwierania pliku w następujący sposób:
````perl
open my $FH, '<', 'plik.md' or die $!;
````
Funkcja **die** przyjmuje komunikat o błędzie jako argument i kończy działanie
programu informując użytkownika o błędzie.

Po zakończeniu pracy z plikiem należy zamknąć uchwyt:
````perl
close $FH;
````

### Odczytywanie plików
Czytanie plików odbywa się tak samo jak czytanie ze standardowego wejścia,
**STDIN** wystarczy zastąpić uchwytem do pliku, z którego dane chcemy wczytać.
````perl
open my $FH, '<', 'plik.in' or die $!;
while (<$FH>) {
    print;
}
close $FH;
````

### Zapisywanie plików
Otwarcie pliku w trybie **>** zeruje plik (usuwa całą jego zawartość) i
pozwala na zapis danych. Analogicznie do odczytu, zapis nie różni się zbytnio
od operacji wypisywania danych na standardowe wyjście.
````perl
open my $FH, '>', 'plik.out' or die $!;
foreach my $data ('some data', 'some other data', 'more data') {
    say $FH "OUT: $data";
}
close $FH;
````
Funkcje **print** i **say** mogą przyjąć uchwyt do pliku jako modyfikator przed
listą argumentów. Ich zachowanie jest dokładnie takie samo jak w przypadku
wypisywania na standardowe wyjście, jedyna różnicą jest fakt, że wyjście trafia
do wybranego pliku.

**UWAGA**: Modyfikator uchwytu do pliku dla **say** i **print** nie jest
typowym argumentem funkcji, więc nie powinno po nim być przecinka.

#### Dopisywanie danych do pliku
Żeby dopisać dane do pliku, bez zerowania go, można użyć trybu **>>**.

#### Domyślny uchwyt wyjściowy
Jeśli nie podamy funkcji **print** lub **say** uchwytu do pliku jako
modyfikatora, wypiszą dane do domyślnego uchwytu wyjściowego. Zazwyczaj jest to
**STDOUT**, ale istnieje możliwość wyboru innego uchwytu za pomocą funkcji
**select**.
````perl
open my $FH, '>', 'plik.out' or die $!;
say 'Standard';
say $FH 'Explicit file'
select $FH;
say 'File';
say STDOUT 'Explicit standard';
close $FH;
````
W wyniku działania tego programu na standardowe wyjście zostanie wypisane:
````
Standard
Explicit standard
````
a do pliku _plik.out_:
````
Explicit file
FILE
````
