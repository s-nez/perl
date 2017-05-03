# Wyszukiwanie
Program uruchamiany w następujący sposób:
```
./prog.pl [lista plików] [string]
```
Program powinien wyświetlić zawartość wszystkich plików z listy,
kolorując w niej wystąpienia napisu [string] na czerwono.

Argument [string] jest obowiązkowy, lista plików może być pusta,
w takim wypadku należy wczytywać standardowe wejście.

Na koniec należy wypisać, ile razy słowo pojawiło się w plikach/wejściu.

**UWAGA:** Program powinien kolorować tylko dokładne wystąpienia napisu, nie
powinien interpretować go jako wyrażenia regularnego.

### Przydatne informacje
Do kolorowania wyjścia w systemach UNIXowych używa się specjalnych znaków. 
Wypisanie znaku  **"\033[31m"** sprawia, że od tej pory tekst będzie
wyświetlany na czerwono. Znak  **"\033[0m"** resetuje kolory.

Wypisanie słowa ERROR na czerwono i wiadomości normalnie:
```perl
my ($COLOR_RED, $COLOR_RESET) = ("\033[31m", "\033[0m");
say "${COLOR_RED}ERROR${COLOR_RESET}: An error has occurred";
```
