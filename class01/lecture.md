# Warsztat 01

## Instalacja
Perl jest zainstalowy domyślnie w większość dystrybucji GNU. Instalacja
pakietu _perl_ powinna wystarczyć do normalnej pracy.

Jeśli ktoś jest zmuszony do używania Windowsa, to
[Strawberry Perl](http://strawberryperl.com/) wydaje się być najlepszą
opcją.

### Edytor
Najprostszy edytor tesktu i terminal wystarczą do pisania i uruchamiania
programów. [Geany](http://www.geany.org/) jest dobrym wyborem na początek.

## Hello World! i uruchamianie programów
Tradycyjny program Hello World! w Perlu:
````
#!/usr/bin/perl
print "Hello World!\n";
````
Jedyne, czego potrzebujemy to charakterystyczny dla języków skryptowych
shebang i instrukcja _print_, której nazwa mówi sama za siebie.

Zakładając, że program został zapisany w pliku _hello.pl_, możemy go
uruchomić poleceniem:
````
perl hello.pl
````
lub, jeśli nadamy mu prawa do wykonywania:
````
./hello.pl
````

## Perldoc
Każda instalacja Perla jest wyposażona w narzędzie _perldoc_. Pozwala
ono czytać dokumentację każdego aktualnie zainstalowaneg modułu,
wbudowanych funkcji i specjalnych zmiennych. Dokumentacja języka
zawiera też szczegółowe instrukcje obsługi i objaśnienia różnych części
języka, jak również wprowadzenia dla początkujących. Dobra dokumentacja
jest częścią kultury Perla.

### Jak używać dokumentacji
Dokumentacja języka:
````
perldoc perltoc
perldoc perlrun
perldoc perlreftut
````
Pierwsze polecenie wyświetli spis treści z krótkimi opisami głównej
dokumentacji języka. Drugie, informacje o parametrach wywołania
interpretera, a trzecie, wprowadzenie do referencji.

Dokumentacja konkretnego modułu:
````
perldoc Data::Dumper
perldoc Reddit::Client
````
Dokumentacja wbudowanych funkcji:
````
perldoc -f sort
perldoc -f push
````
Opisy specjalnych zmiennych:
````
perldoc -v '$_'
perldoc -v '$.'
perldoc -v '@ARGV'
````
**UWAGA:** Wiele powłok używa $ do oznaczania swoich zmiennych, dlatego
dobrym zwyczajem jest brać argumenty _perldoc -v_ w pojedynczy cudzysłów.

### Przydatne strony dokumentacji
````
perldoc perlintro # krótkie wprowadzenie do języka
perldoc perlstyle # styl kodu
perldoc perlcheat # ściąga ze wszystkich podstawowych elementów składni
perldoc perltrap  # pułapki i niuanse języka, na które trzeba uważać
````
