# CSV
Wczytaj plik CSV i wypisz dane w formie ponumerowanej tabeli.
Nazwa pliku z danymi zostanie podana jako pierwszy i jedyny argument programu:
```
program.pl [plik.csv]
```
Program powinien zwrócić błąd jeśli nazwa pliku nie zostanie podana.

Plik z danymi składa się z wierszy danych o takiej samej ilości wpisów
oddzielonych przecinkami.
Jeśli któryś z wpisów w pliku jest równy hasłu: _'hunter2'_, należy zamiast
niego wypisać ciąg gwiazdek(_'*'_) o takiej samej długości.

Jeśli hasło wystąpiło w pliku przynajmniej raz, należy wypisać na koniec
ilość jego wystąpień.

**UWAGA:** interesują nas tylko pełne wpisy, wpis o treści _'hunter22'_ należy
zostawić bez zmian.

## Przykładowe wejście i wyjście
```
./ex06-csv.pl file.csv
```
Zawartość pliku file.csv:
```
martin,hunter3,54,beer and wine
john,gr32fds,21,hunter
mary,hunter2,90,deer1
huebert,hue,17,hunter2
```
Wyjście:
```
+-------+-------+--+-------------+
| martin|hunter3|54|beer and wine|
+-------+-------+--+-------------+
|   john|gr32fds|21|       hunter|
+-------+-------+--+-------------+
|   mary|*******|90|        deer1|
+-------+-------+--+-------------+
|huebert|    hue|17|      *******|
+-------+-------+--+-------------+

Wystąpienia hasła: 2
```
