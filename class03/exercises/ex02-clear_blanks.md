# Usuwanie zbędnych białych znaków

Napisz skrypt, który usunie z pliku tekstowego nadmiarowe białe znaki na
końcach linii. Jedynym argumentem skryptu powinna być ścieżka do pliku. Jeśli
plik zawiera następujące po sobie puste linie (składające się tylko z białych
znaków), należy złączyć je w jedną pustą linię.

Przykładowy plik [ex02-clear\_blanks.input](https://github.com/slimakuj/perl/blob/master/class03/ex02-clear_blanks.input)
(cudzysłów dodany dla widoczności biały znaków):
```
$ perl -nle 'print qq["$_"]' ex02-clear_blanks.input
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis nunc"
"ut augue mattis facilisis. Aliquam dignissim augue vel blandit vehicula. Nulla      "
"mollis nisi nec euismod convallis. Sed commodo justo nisl, luctus finibus leo"
"volutpat non. Donec libero tortor, placerat nec aliquam vel, aliquet at ante.      "
"Morbi massa odio, placerat at laoreet ac, mattis id orci."
""
"Nunc vitae pellentesque libero. Fusce mollis semper faucibus. Sed sem mi,     "
"convallis id convallis a, finibus maximus libero. Praesent nisi magna,"
"hendrerit vitae lorem id, ullamcorper viverra augue. Integer quis tellus        "
"tortor. Nulla facilisi.  Etiam nec scelerisque sapien. Duis quis purus eget"
"ipsum maximus sodales a quis libero. Fusce id sollicitudin diam. Cras at"
"feugiat tellus, vitae tempor magna."
""
""
""
""
"Phasellus vitae eros in elit blandit ullamcorper. Integer luctus justo ac odio"
"bibendum, ac sodales massa eleifend. Morbi pulvinar varius sem, vel sodales      "
"velit maximus sed. Proin nibh lacus, dapibus eu dapibus in, vehicula non nulla."
"        "
""
"Sed et urna est. Quisque a sem quis lacus congue laoreet non at felis. Quisque"
"tortor diam, molestie ullamcorper pulvinar ac, gravida id turpis. Morbi lectus"
"mauris, rhoncus at scelerisque id, finibus ac metus.         "
```

Zawartość pliku po wykonaniu na nim programu:
```
$ perl clear_blanks.pl ex02-clear_blanks.input
$ perl -nle 'print qq["$_"]' ex02-clear_blanks.input
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis nunc"
"ut augue mattis facilisis. Aliquam dignissim augue vel blandit vehicula. Nulla"
"mollis nisi nec euismod convallis. Sed commodo justo nisl, luctus finibus leo"
"volutpat non. Donec libero tortor, placerat nec aliquam vel, aliquet at ante."
"Morbi massa odio, placerat at laoreet ac, mattis id orci."
""
"Nunc vitae pellentesque libero. Fusce mollis semper faucibus. Sed sem mi,"
"convallis id convallis a, finibus maximus libero. Praesent nisi magna,"
"hendrerit vitae lorem id, ullamcorper viverra augue. Integer quis tellus"
"tortor. Nulla facilisi.  Etiam nec scelerisque sapien. Duis quis purus eget"
"ipsum maximus sodales a quis libero. Fusce id sollicitudin diam. Cras at"
"feugiat tellus, vitae tempor magna."
""
"Phasellus vitae eros in elit blandit ullamcorper. Integer luctus justo ac odio"
"bibendum, ac sodales massa eleifend. Morbi pulvinar varius sem, vel sodales"
"velit maximus sed. Proin nibh lacus, dapibus eu dapibus in, vehicula non nulla."
""
"Sed et urna est. Quisque a sem quis lacus congue laoreet non at felis. Quisque"
"tortor diam, molestie ullamcorper pulvinar ac, gravida id turpis. Morbi lectus"
"mauris, rhoncus at scelerisque id, finibus ac metus."
```

## Przydatne informacje
Polecenie:
```
$ perl -nle 'print qq["$_"]' plik
```
wypisze zawartość pliku z cudzysłowem dookoła każdej linii. Można w ten sposób
łatwo zobaczyć, czy plik zawiera nadmiarowe białe znaki
