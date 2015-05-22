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
