# Sortowanie zdjęć

Używając modułu [Image::ExifTool](https://metacpan.org/pod/Image::ExifTool)
napisz skrypt, który posortuje zdjęcia do katalogów według daty wykonania.

Skrypt powinien przyjmować jeden argument - ścieżkę do katalogu ze zdjęciami.

Dla każdego zdjęcia w podanym katalogu należy sprawdzić jego datę wykonania
(wartość "CreateDate") i przenieść zdjęcie do katalogu "YYYY/MM", gdzie "YYYY"
to rok wykonania zdjęcia, a "MM" to miesiąc. Zdjęcie wykonane 15.04.2015 należy
umieścić w katalogu "2015/04" (jeśli katalog nie istnieje, należy go stworzyć).

Dla uproszczenia można przyjąć, że katalog zawiera tylko zdjęcia.

## Przydatne informacje

Funkcja **ImageInfo** zwraca referencję do hasza z informacjami EXIF zdjęcia.
Żeby uzyskać konkretny klucz należy użyć notacji **->** :
```perl
my $create_date = Image::ExifTool::ImageInfo('DSC0001.jpg')->{CreateDate};
```

Alternatywnie, można też "rozpakować" referencję do zwykłego hasza:
```perl
my %img_info    = %{ Image::ExifTool::ImageInfo('DSC0001.jpg') };
my $create_date = $img_info{CreateDate};
```
