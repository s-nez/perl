# Pytania i odpowiedzi
<!--TOC_START--->
* [Q: Perl ciągle wyrzuca błędy, co jest nie tak?](#q-perl-ciągle-wyrzuca-błędy-co-jest-nie-tak)
* [Q: Co to znaczy "_Global symbol "$x" requires explicit package name_"?](#q-co-to-znaczy-_global-symbol-x-requires-explicit-package-name_)
* [Q: Jak pominąć niektóre wartości zwracane przez **split**?](#q-jak-pominąć-niektóre-wartości-zwracane-przez-split)

<!--TOC_END--->

## Q: Perl ciągle wyrzuca błędy, co jest nie tak?
**A:** Jeśli domyślne komunikaty o błędach mało Ci mówią, spróbuj dodać na
początku programu:
````perl
use diagnostics;
````
Perl wypisze wtedy dużo bardziej rozbudowane komunikaty, z sugestiami, co
może być źle.

Przeczytaj dokumentację (perldoc) funkcji, których używasz, być może nie
do końca robią to, czego się spodziewasz.

Dodaj nowy problem ([Issue](https://github.com/slimakuj/perl/issues/new))
do repozytorium z materiałami. Pamiętaj, żeby opisać swój problem i dodać
adekwatny kod.

## Q: Co to znaczy "_Global symbol "$x" requires explicit package name_"?
**A:** Najprawdopodobniej zmienna $x nie została zadeklarowana, została
użyta poza swoim zakresem albo jest to literówka. Sprawdź gdzie zmienna
została zadeklarowana i czy użyta nazwa na pewno się zgadza.

## Q: Jak pominąć niektóre wartości zwracane przez **split**?
**A:** Jeśli przypiszemy **split** do listy, funkcja zatrzyma się po
znalezieniu odpowiedniej ilości napisów. Jeśli chcemy pominąć jakieś zmienne
"w środku" tej listy, bez potrzeby tworzenia tymczasowych zmiennych, możemy
użyć **undef**.
````perl
my ($user, undef, $uid) = split ':', 'john:x:1001';
````
Wtedy **$user** = _'john'_, **$uid** = _'1001'_, a _'x'_ zostaje pominięty.
