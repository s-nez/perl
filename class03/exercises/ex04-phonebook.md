# Książka telefoniczna
Wczytaj plik zawierający wpisy z nazwiskiem, numerem telefonu i miastem w
następującym formacie:
````
Imię Nazwisko, telefon, miasto
...
````
Podziel wpisy według miast i dla każdego miasta wypisz nazwiska z numerami
telefonów w następujący sposób:
````
----------
Miasto

Nazwisko1 Imię1 - telefon1
Nazwisko2 Imię2 - telefon2
...
````

Wpisy w każdym mieście powinny być posortowane według nazwisk, a miasta
według ilości wpisów, malejąco, w przypadku równej ilości wpisów,
decyduje kolejność alfabetyczna.

## Przykładowe wejście i wyjście
Dla przykłądowego pliku [ex04-phonebook.input](https://github.com/slimakuj/perl/blob/devel/class03/exercises/ex04-phonebook.input):
````
Krzysztof Chuciński, 123456789, Warszawa
Marcin Matajski, 543123903, Poznań
Damian Korba, 391405811, Łódź
Marian Gwiazda, 320120430, Warszawa
Maciej Śluza, 418828936, Kraków
Marcelina Węgorz, 604854422, Toruń
Włodzimierz Kisiel, 391197314, Gdańsk
Kacper Trawa, 223145071, Warszawa
Czesław Madera, 643874927, Kraków
Cezary Szpon, 106142678, Poznań
Jakub Kosa, 667591021, Kraków
Jan Buła, 595057360, Gdańsk
Tomasz Nowak, 212432158, Toruń
Grzegorz Matusiak, 232438653, Bydgoszcz
Krystian Szyjski, 677249151, Warszawa
Mieczysław Łopata, 765232925, Poznań
Piotr Skała, 462179250, Kraków
Ludwik Morawa, 315290703, Toruń
Paweł Mors, 616596074, Bydgoszcz
Kajetan Wolski, 543368850, Poznań
Stefan Mielizna, 247433687, Kraków
Danuta Ogórek, 742205640, Toruń
Katarzyna Dżem, 992489181, Łodź
Joanna Marmolada, 290834207, Łodź
````
Wyjście:
````
----------
Kraków

Kosa Jakub - 667591021
Madera Czesław - 643874927
Mielizna Stefan - 247433687
Skała Piotr - 462179250
Śluza Maciej - 418828936
----------
Poznań

Matajski Marcin - 543123903
Szpon Cezary - 106142678
Wolski Kajetan - 543368850
Łopata Mieczysław - 765232925
----------
Toruń

Morawa Ludwik - 315290703
Nowak Tomasz - 212432158
Ogórek Danuta - 742205640
Węgorz Marcelina - 604854422
----------
Warszawa

Chuciński Krzysztof - 123456789
Gwiazda Marian - 320120430
Szyjski Krystian - 677249151
Trawa Kacper - 223145071
----------
Łódź

Dżem Katarzyna - 992489181
Korba Damian - 391405811
Marmolada Joanna - 290834207
----------
Bydgoszcz

Matusiak Grzegorz - 232438653
Mors Paweł - 616596074
----------
Gdańsk

Buła Jan - 595057360
Kisiel Włodzimierz - 391197314
----------
````
