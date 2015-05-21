# Użytkownicy systemu
Wypisz nazwy (pełne i systemowe) wszystkich "normalnych" użytkowników
systemu wykorzystując informacje zawarte w /etc/passwd. Na koniec wypisz
też liczbę takich użytkowników.

## Format wyjścia:
```
nazwa-systemowa1: pełna nazwa1
nazwa-systemowa2: pełna nazwa2
...
nazwa-systemowaN: pełna nazwaN

Liczba użytkowników: N
```

## Przykładowe wejście i wyjście
Przykładowa zawartość /etc/passwd:
```
root:x:0:0:root:/root:/bin/bash
mysql:x:27:27:MySQL Server:/var/lib/mysql:/sbin/nologin
jan:x:1000:1000:Jan Kowalski:/home/jan:/bin/bash
karol:x:1001:1000:Karol Buc:/home/karol:/bin/zsh
postgres:x:26:26:PostgreSQL Server:/var/lib/pgsql:/bin/bash
```
Oczekiwane wyjście:
```
jan: Jan Kowalski
karol: Karol Buc

Liczba użytkowników: 2
```

## Przydatne informacje:
UID "normalnych" użytkowników mieszczą się zwykle w przedziale [1000, 60000]

[Znaczenie poszczególnych pól pliku](https://en.wikipedia.org/wiki/Passwd_%28file%29#Password_file)
