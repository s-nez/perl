# Zmiana nazw plików
Napisz program, który przyjmie napis X jako pierwszy argument i zmieni nazwy
wszystkich zwykłych plików plików (nie folderów) w aktualnym folderze na
X-N, gdzie N to liczba naturalna.

Zakładając, że w aktualnym folderze jest 5 plików, po wykonaniu:
````
./prog.pl file
````
zawartość folderu powinna wyglądać następująco:
````
file-0
file-1
file-2
file-3
file-4
````

## Przydatne informacje
Wykonanie poniższego polecenia stworzy 10 pustych plików z losowymi nazwami
w aktualnym folderze:
````
perl -e 'open $F, ">", join("", map {chr(rand(25)+97)} 1..rand(10)+5) for 1..10'
````
