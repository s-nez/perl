# Diff
Napisz prosty program porównujący pliki linia po linii. Nazwy dwóch plików
zostaną podane jako argumenty programu:
````
./diff.pl file1 file2
````
Należy sprawdzić, czy pliki są identyczne. Jeśli tak, to na wyjście powinien
zostać wypisany komunikat:
````
Files file1 and file2 are identical
````
W przeciwnym razie, dla tych linii, na których pliki sie różnią,
należy wypisać numer linii i jej zawartośc w obu plikach.
Przykładowo, dla plików _file1_ i _file2_ o zawartościach:  
file1:
````
line
another line
hue
````
file2:
````
line
another line not the same
hue
````
należy wypisać:
````
Line 2:
< another line
---
> another line not the same
````

## Przydatne informacje
Wykonanie poniższego polecenia stworzy dwa pliki z nazwami i zawartością
jak w podanym przykładzie:
````
echo -e "line\nanother line\nhue" > file1; echo -e "line\nanother line not the same\nhue" > file2
````
