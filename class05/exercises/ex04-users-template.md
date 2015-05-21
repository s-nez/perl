# Informacje i szablon
Wczytaj plik ex04-users-template.input w dziwnym, hybrydowym formacie INI-XML.
W pliku są 3 rodzaje sekcji:

### Sekcja <users>
Sekcja users zaczyna się od znacznika **<users>** i kończy znacznikiem
**</users>**. Wewnątrz sekcji znajdują się zestawy informacji o użytkownikach
w formacie podobnym do pliku INI - na początku znajduje się nazwa użytkownika
w kwadratowych nawiasach, potem podane są dane użytkownika w formie:
```
nazwa = "wartość"
```
O każdym użytkowniku będą dostępne 4 informacje:
* name
* email (może się pojawić jako _email_ lub _e\-mail_)
* role
* level (może się pojawić jako _level_ lub _lvl_)

Wartości muszą być wzięte w pojedynczy lub podwójny cudzysłów, a między nazwą
lub wartością, a znakiem = może być dowolna ilość białych znaków (w tym 0).

Sekcja danych konkretnego użytkownika kończy sie, kiedy pojawia się nowy
znacznik użytkownika (nazwa w nawiasie kwadratowym).

Dane użytkownika mogą pojawiać się w dowolnej kolejności, w pliku może się też
pojawić kilka sekcji **<users>**.

Nazwy użytkowników nie powtarzają się, tak samo jak pola z danymi o nich.

### Sekcja <template>
Sekcja template zaczyna się od znacznika **<template>** i kończy znacznikiem
**</template>**, zawiera tekst szablonu, do którego należy wstawić dane
użytkowników.

### Sekcja <select>
Sekcja select zaczyna się znacznikiem **<select>** i kończy znacznikiem **</select>**. Zawiera oddzielone białymi znakami nazwy użytkowników.

## Polecenie
Dla każdego użytkownika, którego nazwa znajduje się w sekcji **select**,
wypisz szablon z sekcji **template** ze wszystkimi nawiasami kwadratowymi
zamienionymi na wartości odpowidnich danych użytkownika. Szablony powinny
być wypisane w kolejności malejącej według poziomu użytkownika (dana _level_).
Szablony powinny być oddzielone znakiem nowej linii.

## Przykładowe wyjście
Wyjście dla pliku ex04-users-template.input:
```
Our level 100 viking is Torlak Torlaksson.
You can contact him via email: torlak@scandinavia.se.

Our level 81 tank is John Smith.
You can contact him via email: john@johnsons.co.uk.

Our level 75 dps is Steven Poulsen.
You can contact him via email: steven@gmail.com.

Our level 53 support is Dany Hill.
You can contact him via email: dany@hi.ll.

```
