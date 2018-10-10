# Pytania i odpowiedzi
<!--TOC_START--->
* [Q: Co się stanie, jeśli zinkrementuję nieistniejący klucz w haszu?](#q-co-się-stanie-jeśli-zinkrementuję-nieistniejący-klucz-w-haszu)
* [Q: Co robi funkcja qw()?](#q-co-robi-funkcja-qw)
* [Q: Dlaczego w moim rozwiązaniu zadania 2 numeracja zaczyna się od 2?](https://github.com/slimakuj/perl/blob/legacy_2016/class02/questions-and-answers.md#q-dlaczego-w-moim-rozwi%C4%85zaniu-zadania-2-numeracja-zaczyna-si%C4%99-od-2)
* [Q: Próbuję wczytać po jednej linijce z każdego z dwóch plików, a dostaję dwie linijki z tego samego pliku. Dlaczego?](#q-próbuję-wczytać-po-jednej-linijce-z-każdego-z-dwóch-plików-a-dostaję-dwie-linijki-z-tego-samego-pliku-dlaczego)
* [Q: Czy mogę skorzystać z domyślnego zachowania **<>**, jeśli któryś z argumentów programu nie jest nazwą pliku?](#q-czy-mogę-skorzystać-z-domyślnego-zachowania--jeśli-któryś-z-argumentów-programu-nie-jest-nazwą-pliku)
* [Q: Nie chce mi się pisać "or die" przy każdym **open**, co począć?](#q-nie-chce-mi-się-pisać-or-die-przy-każdym-open-co-począć)

<!--TOC_END--->

## Q: Co się stanie, jeśli zinkrementuję nieistniejący klucz w haszu?
**A:** Nieistniejący klucz zostanie potraktowany jako **undef** w kontekście
numerycznym, czyli efektywnie 0, co oznacza, że dany klucz zostanie
stworzony i będzie miał wartość 1.
````perl
my %hash; # brak jakichkolwiek kluczy
++$hash{key}; # teraz hash ma jeden klucz - "key", z wartością 1
````

## Q: Co robi funkcja qw()?
**A:** Funkcja qw() tworzy listę ze słów oddzielonych białymi znakami.
Wyrażenie:
````perl
my @list = qw(one two three);
````
zadziała dokładnie tak samo jak:
````perl
my @list = ('one', 'two', 'three');
````
Jest to wygodna funkcja, która pozwala nam mniej pisać.

## Q: Dlaczego w moim rozwiązaniu [zadania 2](https://github.com/slimakuj/perl/blob/legacy_2016/class02/exercises/ex02-rename.md) numeracja zaczyna się od 2?
**A:** Prawdopodobnie nie sprawdzasz, czy dany plik jest folderem przed
zmianą nazwy. W każdym folderze znajdują się dwa specjalne pliki - '.' i
'..', które oznaczają "aktualny folder" i "folder powyżej", ich nazw nie
można zmieniać. Są technicznie uznawane za foldery, więc pominięcie
folderów, zgodnie z treścią zadania, pozwoli uniknąć tego błędu.

## Q: Próbuję wczytać po jednej linijce z każdego z dwóch plików, a dostaję dwie linijki z tego samego pliku. Dlaczego?
**A:** Jeśli próbujesz wczytać linijkę z uchwytu **$FH1** do zmiennej
**$line1** i linijkę z **$FH2** do zmiennej **$line2** w następujący sposób:
````perl
my ($line1, $line2) = (<$FH1>, <$FH2>);
````
narzucasz kontekst listowy na **<$FH1>** i **<$FH2>**, w związku z czym,
wczytują one wszystkie linie w swoich plikach do tej listy. Żeby wczytać po
jedej linijce z każdego pliku, należy na obydwie operacje odczytu narzucić
kontekst skalarny:
````perl
my ($line1, $line2) = (scalar <$FH1>, scalar <$FH2>);
````

## Q: Czy mogę skorzystać z domyślnego zachowania **<>**, jeśli któryś z argumentów programu nie jest nazwą pliku?
**A:** Tak, wystarczy usunąć ten argument z **@ARGV** przd użyciem **<>**.
Np.  jeśli przeszkadza w tym pierwszy argument programu, możemy go wczytać
za pomocą **shift**:
````perl
my $arg = shift;
````
Wtedy program uruchomiony w następujący sposób:
````
./prog.pl -x
````
nie zwróci błędu o nieistniejącym pliku "-x", a **<>** będzie wczytywał
standardowe wejście, tak jakby program nie dostał żadnych argumentów.

## Q: Nie chce mi się pisać "or die" przy każdym **open**, co począć?
**A:** Dodaj następującą linijkę na początku programu:
````perl
use autodie;
````
Teraz wszytkie błędy **open** (i innych wywołań systemowych) zostaną
automatycznie obsłużone i stosowne informacje o nich będą wypisywane
na ekran.
