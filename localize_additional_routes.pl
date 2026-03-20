use strict;
use warnings;

my @one_level = (
  'blog/index.html',
  'bookgiveawaythekindnessseed/index.html',
  'search/index.html',
);

my @two_level = (
  'post/let-me-introduce-myself/index.html',
);

my @routes = (
  ['https://www.karamullaneauthor.com/post/let-me-introduce-myself', 'post/let-me-introduce-myself/'],
  ['https://www.karamullaneauthor.com/bookgiveawaythekindnessseed', 'bookgiveawaythekindnessseed/'],
  ['https://www.karamullaneauthor.com/blog-feed.xml', 'blog-feed.xml'],
  ['https://www.karamullaneauthor.com/blog', 'blog/'],
  ['https://www.karamullaneauthor.com/search', 'search/'],
  ['https://www.karamullaneauthor.com/books', 'books/'],
  ['https://www.karamullaneauthor.com/about', 'about/'],
  ['https://www.karamullaneauthor.com/emmisworld', 'emmisworld/'],
  ['https://www.karamullaneauthor.com/resources', 'resources/'],
  ['https://www.karamullaneauthor.com/the-kindness-seed', 'the-kindness-seed/'],
  ['https://www.karamullaneauthor.com/bookworm-burrow-gift-book-bundle', 'bookworm-burrow-gift-book-bundle/'],
  ['https://www.karamullaneauthor.com/state-fair-fun-money', 'state-fair-fun-money/'],
  ['https://www.karamullaneauthor.com/rainbow-colors', 'rainbow-colors/'],
  ['https://www.karamullaneauthor.com/great-explorers', 'great-explorers/'],
  ['https://www.karamullaneauthor.com/grandes-exploradores', 'grandes-exploradores/'],
  ['https://www.karamullaneauthor.com/observationlogbook', 'observationlogbook/'],
  ['https://www.karamullaneauthor.com/privacy-policy', 'privacy-policy/'],
  ['https://www.karamullaneauthor.com/affiliate-link-disclosure-notice', 'affiliate-link-disclosure-notice/'],
  ['https://www.karamullaneauthor.com/terms-of-service', 'terms-of-service/'],
  ['https://www.karamullaneauthor.com/hoop-house-press', 'hoop-house-press/'],
  ['https://www.karamullaneauthor.com/', './'],
  ['https://www.karamullaneauthor.com', './'],
);

sub slurp {
  my ($file) = @_;
  open my $fh, '<', $file or die "Cannot read $file: $!";
  local $/;
  return <$fh>;
}

sub spew {
  my ($file, $text) = @_;
  open my $fh, '>', $file or die "Cannot write $file: $!";
  print {$fh} $text;
}

sub replace_pairs {
  my ($text, $pairs) = @_;
  for my $pair (@$pairs) {
    my ($from, $to) = @$pair;
    $text =~ s/\Q$from\E/$to/g;
  }
  return $text;
}

sub prefixed_routes {
  my ($prefix) = @_;
  my @mapped;

  for my $pair (@routes) {
    my ($from, $to) = @$pair;
    my $mapped = $to eq './' ? $prefix : "$prefix$to";
    push @mapped, [$from, $mapped];
  }

  return \@mapped;
}

for my $file (@one_level) {
  my $text = slurp($file);
  $text = replace_pairs($text, prefixed_routes('../'));
  $text =~ s#(["'\(=])(media|fonts|services|tag-bundler|unpkg|7\.120\.3|onsite)/#$1../$2/#g;
  $text =~ s#href="(?:\.\./)?index\.html"#href="../"#g;
  spew($file, $text);
}

for my $file (@two_level) {
  my $text = slurp($file);
  $text = replace_pairs($text, prefixed_routes('../../'));
  $text =~ s#(["'\(=])(media|fonts|services|tag-bundler|unpkg|7\.120\.3|onsite)/#$1../../$2/#g;
  $text =~ s#href="(?:\.\./)?index\.html"#href="../../"#g;
  spew($file, $text);
}

my $feed = slurp('blog-feed.xml');
$feed =~ s#https://www\.karamullaneauthor\.com/blog-feed\.xml#https://quixotie.github.io/hello-world/blog-feed.xml#g;
$feed =~ s#https://www\.karamullaneauthor\.com/blog#https://quixotie.github.io/hello-world/blog/#g;
$feed =~ s#https://www\.karamullaneauthor\.com/post/let-me-introduce-myself#https://quixotie.github.io/hello-world/post/let-me-introduce-myself/#g;
spew('blog-feed.xml', $feed);