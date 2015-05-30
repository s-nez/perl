# Przykłady użycia modułów
## Reddit::Client
Pobranie 3 najnowszych tytułów wpisów z
[r/perl](http://www.reddit.com/r/perl):
```perl
use Reddit::Client;

my $reddit = Reddit::Client->new(user_agent => 'Perl/5.18');
my $links = $reddit->fetch_links(subreddit => "/r/perl", limit => 3);
foreach my $link (@{ $links->{items} }) {
    say $link->{title};
}
```

## File::Fetch
Pobranie obrazka z wielbłądem z [perl.org](http://www.perl.org/):
```perl
use File::Fetch;

sub download {
    my $uri = shift;
    my $ff = File::Fetch->new(uri => $uri);
    return ($ff->fetch() or die $ff->error);
}

download('http://st.pimg.net/perlweb/images/camel_head.v25e738a.png');
```

## Term::ProgressBar::Simple
Wyświetlenie paska postępu, który przesuwa się o 10% co sekundę:
```perl
use Term::ProgressBar::Simple;

my $progress = Term::ProgressBar::Simple->new({ count => 10});
for (1 .. 10) {
    sleep 1;
    ++$progress;
}
```

## Clipboard
Wyświetlenie na ekranie zawartości schowka systemowego:
```perl
use Clipboard;

print Clipboard->paste();
```
