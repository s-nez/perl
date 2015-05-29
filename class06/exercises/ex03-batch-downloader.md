# Batch downloader
Napisz program, który będzie umożliwiał pobieranie plików z adresów
zapisanych w pliku.

Program będzie przyjmował dwa argumenty:
* tryb - '-a', '-d' lub '-r'
* nazwę pliku

Argumenty mogą zostać podane w dowolnej kolejności. Jeśli podana zostanie
więcej niż jedna flaga trybu, program powinien zwrócić błąd:
```
BŁĄD: Za dużo trybów
```

Jeśli tryb nie zostanie podany, program powinien zwrócić:
```
BŁĄD: Nie podano prawidłowego trybu
```

Jeśli nazwa pliku nie zostanie podana, program powinien zwrócić:
```
BŁĄD: Nie podano nazwy pliku
```

### Tryb -a
Uruchomienie programu z trybem **-a** weźmie zawartość schowka systemowego
i sprawdzi, czy zawiera on coś, co wygląda jak link. Jeśli będzie wyglądało
jak link spyta użytkownika czy chce dodać link do pliku:

Wywołanie:
```
./prog.pl -a filename
```
Wyjście:
```
Schowek zawiera: http://jakis.link.com
Dodać link do pliku? [t/n]:
```

Użytkownik wpisuje odpowiedź, w przypadku odpowiedzi "t", link zostaje
dopisany na koniec pliku _filename_, dla innej odpowiedzi, program kończy
działanie i nic się nie dzieje.

### Tryb -d
Jeśli program zostanie uruchomiony w trybie **-d**, spróbuje pobrać pliki
z adresów znajdujących się w pliku podanym jako drugi argument. Pobrane
pliki należy umieścić w aktualnym folderze.

Podczas pobierania program powien wyświetlać pasek postępu, sygnalizujący,
jaka część plików została już pobrana.

Po udanym pobraniu plików, plik z linkami powinien zostać usunięty.

### Tryb -r
W trybie **-r**, program powinien wyświetlić ponumerowana listę linków
znajdujących się w pliku. Następnie, powinien spytać użytkownika o listę
linków, które chce usunąć.

Jeśli podano jakiekolwiek prawidłowe numery linków, należy je usunąć z pliku.

## Przydatne informacje
Do przetwarzania flag na linii poleceń służy wbudowany moduł Getopt::Std.

Do pobierania plików można użyć modułu
[File::Fetch](https://metacpan.org/pod/File::Fetch).

Moduł
[Term::ProgressBar::Simple](https://metacpan.org/pod/Term::ProgressBar::Simple)
umożliwia tworzenie prostych pasków postępu.

Moduł [Clipboard](https://metacpan.org/pod/Clipboard) udostępnia interfejs
do schowka systemowego.
