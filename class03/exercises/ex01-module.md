# Moduł
Rekordy z baz danych często reprezentowane są w Perlu jako tablice haszy.
Napisz moduł **Record** udostępniający kilka prostych operacji
na takich strukturach.

Każda funkcja ma przyjmować dwa argumenty: referencję do tablicy
i referencję do hasza. Pierwszy argument to struktura danych, na której
będziemy operować, drugi to hasz parametrów definiujących tą operację.

## Przykładowa struktura

Tabela w bazie danych:
```
+-------+------+---------+------+
| userid|  name|  surname| score|
+-------+------+---------+------+
|      1|John  |   Wilson|    12|
|      2|Mike  | Cleevers|  NULL|
|      3|Kate  | Hamilton|    18|
|      4|Mighty|      Hue|   543|
+-------+------+---------+------+
```

Struktura danych w Perlu:
```perl
[
    { userid => 1, name => 'John',   surname => 'Wilson',   score => 12 },
    { userid => 2, name => 'Mike',   surname => 'Cleevers', score => undef },
    { userid => 3, name => 'Kate',   surname => 'Hamilton', score => 18 },
    { userid => 4, name => 'Mighty', surname => 'Hue',      score => 543 },
]
```

Przykładowe wywołania fukncji z modułu **Record**:
```perl
Record::set($array_ref, { score => 0 });
Record::default($array_ref, { score => 0 });
Record::move(\@users, { surname => 'last_name' });
Record::copy($ref, { name => 'first_name', surname => 'last_name' });
```

## Funkcje

### set(ARRAYREF, PARAMS)
Dla każdego wiersza, ustaw klucze PARAMS na ich wartości. Jeśli klucz istnieje,
należy go nadpisać, jeśli nie istnieje, należy go stworzyć.

```perl
my @array = (
    { test => 1, stuff => 'xxx' },
    {            stuff => undef },
    { test => 7, stuff => 'max' },
);
Record::set(\@array, { test => 10 });

print Dumper \@array;
```

Oczekiwany wynik:
```perl
$VAR1 = [
    {
        'test' => 10,
        'stuff' => 'xxx'
    },
    {
        'stuff' => undef,
        'test' => 10
    },
    {
        'stuff' => 'max',
        'test' => 10
    }
];
```

### default(ARRAYREF, PARAMS)
Dla każdego wiersza, ustaw klucze PARAMS na ich wartości jeśli nie istnieją
lub są niezdefiniowane.

```perl
my @array = (
    { test => 1, stuff => 'xxx' },
    {            stuff => undef },
    { test => 7, stuff => 'max' },
);
Record::default(\@array, { test => 10, stuff => 'min' });

print Dumper \@array;
```

Oczekiwany wynik:
```perl
$VAR1 = [
    {
        'test' => 1,
        'stuff' => 'xxx'
    },
    {
        'stuff' => 'min',
        'test' => 10
    },
    {
        'stuff' => 'max',
        'test' => 7
    }
];
```

### move(ARRAYREF, PARAMS)
Dla każdego wiersza, przenieś elementy z kluczy PARAMS do ich wartości.
Jeśli dany klucz nie istnieje, pozostaw rekord bez zmian.

```perl
my @array = (
    { test => 1, stuff => 'xxx' },
    {            stuff => undef },
    { test => 7, stuff => 'max' },
);
Record::move(\@array, { test => 'production' });

print Dumper \@array;
```

Oczekiwany wynik:
```perl
$VAR1 = [
    {
        'production' => 1,
        'stuff' => 'xxx'
    },
    {
        'stuff' => undef
    },
    {
        'stuff' => 'max',
        'production' => 7
    }
];
```

### copy(ARRAYREF, PARAMS)
Dla każdego wiersza, skopiuj elementy z kluczy PARAMS do ich wartości.
Jeśli dany klucz nie istnieje, pozostaw rekord bez zmian.

```perl
my @array = (
    { test => 1, stuff => 'xxx' },
    {            stuff => undef },
    { test => 7, stuff => 'max' },
);
Record::move(\@array, { test => 'production' });

print Dumper \@array;
```

Oczekiwany wynik:
```perl
$VAR1 = [
    {
        'test' => 1,
        'production' => 1,
        'stuff' => 'xxx'
    },
    {
        'stuff' => undef
    },
    {
        'test' => 7,
        'stuff' => 'max',
        'production' => 7
    }
];
```
