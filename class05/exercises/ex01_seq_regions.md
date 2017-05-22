# Znajdowanie regionów bogatych w GC/AT

W podanej sekwencji DNA znajdź regiony bogate w nukleotydy GC lub AT
(zawierające odpowiedni procent nukleotydów GC lub AT). Program powinien
przyjmować następujące argumenty:

* --mode - "at" lub "gc", określa zbiór nukleotydów do sprawdzenia
* --size - rozmiar regionów do znalezienia (liczba nukleotydów)
* --from - dolna granica procentowa zawartości nukleotydów
* --to   - górna granica procentowa zawartości nukleotydów
* --help - jeśli ten argument zostanie podany, należy tylko wyświetlić pomoc

## Przykładowy region

Region o rozmiarze 10, zawierający 60% nukleotydów GC:
```
AGATCGTCCG
```

Wywołanie programu, które powinno znaleźć taki region (zakładając, że
some\_sequence.txt go zawiera):
```
perl regions.pl --mode gc --from 60 --to 60 --size 10 some_sequence.txt
```
