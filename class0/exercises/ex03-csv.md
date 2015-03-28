# CSV
Wczytaj plik CSV i wypisz dane w formie tabeli.
Dane do programu zostaną podane w formie argumentów linii poleceń:
````
program.pl [plik.csv] [separator] [hasło]
````
plik.csv - nazwa pliku do wczytania
separator - znak oddzielający wpisy w pliku, domyślnie ','
hasło - dane, które trzeba zamienić na gwiazdki, domyślnie 'hunter2'

Tylko pierwszy argument jest niezbędny, program powinien zwrócić błąd
jeśli nie zostanie on podany, w przypadku braku pozostałych argumentów
należy przyjąc domyślne wartości.

Jeśli któryś z wpisów w pliku jest hasłem, należy zamiast niego wypisać
ciąg gwiazdek('*') o takiej samej długości.

Jeśli hasło wystąpiło w pliku przynajmniej raz, należy wypisać na koniec
ilość jego wystąpień.

**UWAGA:** interesują nas tylko pełne wpisy, jeśli hasło to 'hunter2', to
'hunter22' należy zostawić bez zmian.

## Przykładowe wejście i wyjście
````
program.pl file.csv ';' 'hunter3'
````
Zawartość pliku file.csv:
````
martin;hunter3;54;beer and wine
john;gr32fds;21;hunter
mary;hunter2;90;deer1
huebert;hue;17;hunter2
````
Wyjście:
````
+-+-------+-------+--+--------------+
|1| martin|*******|54| beer and wine|
+-+-------+-------+--+--------------+
|2|   john|gr32fds|21|        hunter|
+-+-------+-------+--+--------------+
|3|   mary|hunter2|90|         deer1|
+-+-------+-------+--+--------------+
|4|huebert|    hue|17|       hunter2|
+-+-------+-------+--+--------------+

Wystąpienia hasła: 1
````
