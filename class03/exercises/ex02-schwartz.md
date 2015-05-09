# Transformata Schwartza
Użyj transformaty Schwartza do posortowania wpisów w /etc/passwd według UID.

# Przykładowe wejście i wyjście
Dla /etc/passwd o następującej zawartości:
````
root:x:0:0:root:/root:/bin/bash
mysql:x:27:27:MySQL Server:/var/lib/mysql:/sbin/nologin
jan:x:1000:1000:Jan Kowalski:/home/jan:/bin/bash
karol:x:1001:1000:Karol Buc:/home/karol:/bin/zsh
postgres:x:26:26:PostgreSQL Server:/var/lib/pgsql:/bin/bash
````
Wyjście:
````
root:x:0:0:root:/root:/bin/bash
postgres:x:26:26:PostgreSQL Server:/var/lib/pgsql:/bin/bash
mysql:x:27:27:MySQL Server:/var/lib/mysql:/sbin/nologin
jan:x:1000:1000:Jan Kowalski:/home/jan:/bin/bash
karol:x:1001:1000:Karol Buc:/home/karol:/bin/zsh
````
