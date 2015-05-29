# Reddit
Napisz skrypt, który przyjmie listę subredditów jako argumenty i wyświetli
po 5 najnowszych tematów z każdego w "pudełku". Tytuły w pudełku nie mogą
być dłuższe niż 70 znaków, jeśli taki się trafi, należy odciąć nadmiar
znaków i zamienić ostatnie 3 na kropki.

## Przykładowe wejście i wyjście
Wywołanie programu:
```
./prog.pl perl gnu
```
Wyjście:
```
--------
| perl |
------------------------------------------------------
| Quack & Hack on DuckDuckGo Instant Answers (Los... |
| JSON in Perl                                       |
| Who is testing the tests?                          |
| 2015.20&21: Blogs, Grant, Release and Progress     |
| Mojolicious hack of the day: Web scraping with ... |
------------------------------------------------------
-------
| gnu |
------------------------------------------------------
| Current free software/free culture related crow... |
| GNU Creator Labels Windows And OS X As Malware,... |
| How do I check how does GNU spend donations?       |
| GNU Guix 0.8.2 released                            |
| Firefox Beta now integrates proprietary Pocket     |
| GuixSD new website design                          |
------------------------------------------------------
```
Od czasu napisania tego zadania najnowsze tytuły mogły się zmienić.
Dla sprawdzenia poprawności swojego rozwiązania należy porównywać z
tymi znajdującymi się na Reddicie.

## Przydatne informacje
Do uzyskiwania danych z Reddit może się przydać moduł
[Reddit::Client](https://metacpan.org/pod/Reddit::Client).

W tytułach zwróconych przez Reddit::Client mogą się znajdować znaki
specjalne HTML, np. '$amp;', jednym z modułów, które pozwalają
przekonwertować takie znaki na zwykły tekst jest
[HTML::Entities](https://metacpan.org/pod/HTML::Entities).
