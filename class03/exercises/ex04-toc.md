# Spis treści

Napisz program generujący spis treści dokumentu Markdown i dopisujący
go do pliku. Program powinien przyjmować jeden argument - ścieżkę do pliku.
```
$ perl markdown_toc.pl ex02-toc.input
```

Spis treści powinien być nieponumerowaną listą nagłówków, z indentacją
odpowiadającą poziomowi nagłówka. Nagłówki zaczynają się od znaków **#**:
```
# Heading 1
## Heading 2
### Heading 3
```

Dla powyższych nagłówków powinien zostać wygenerowany następujący spis treści:
```
* Heading 1
    * Heading 2
        * Heading 3
```

Spis treści powinien otrzymać własny nagłówek i zostać dopisany na końcu pliku.

Przykładowy plik wejściowy:
[ex02-toc.input](https://github.com/slimakuj/perl/blob/master/class03/exercises/ex04-toc.input)
