# Numerowanie tagów
Wczytuj standardowe wejście lub pliki podane jako argumenty programu aż do EOF.
Zastąp każde wystąpienie tagu w formacie:
```
<tag>
```
jego ponumerowaną formą:
```
<tag-[NR]>
```
gdzie [NR] to liczba całkowita, która odpowiada numerowi wystąpienia danego
tagu. To znaczy: pierwsze wystąpienie tagu **\<tag\>** należy zamienić na
**\<tag-0\>**, drugie na **\<tag-1\>** itd. Każdy tag ma swoją własna, niezależną
 numerację.

## Przykładowe wejście i wyjście
Wejście:
```
fdsfds fdsfds f ds <test> fds <test>
<test> <diff> <test>ffdsd <diff>
<version> <diff> fds fds <test>
<diff> fdsfs
<version>
test dif version <fidd>
<dif> <diff> <version>
```

Wyjście:
```
fdsfds fdsfds f ds <test-0> fds <test-1>
<test-2> <diff-0> <test-3>ffdsd <diff-1>
<version-0> <diff-2> fds fds <test-4>
<diff-3> fdsfs
<version-1>
test dif version <fidd-0>
<dif-0> <diff-4> <version-2>
```
