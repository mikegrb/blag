---
layout: post
title: Finding Stuff In Your Local CPAN Mirror
date: 2014-08-12 15:28:42 -04:00
tags: geek perl cpan minicpan
comments: yes
---

So you've got this great new [local CPAN you can use to install stuff](http://michael.thegrebs.com/2014/08/08/taking-cpan-with-you/)
you know about but how do you find stuff you don't know about? There are two
main ways I inspect the contents of my local CPAN mirror.  The first is a simple
shell function for searching package names, the second, has a bit more to it but
we will save that for later.

grep to the Rescue
------------------
One of the metadata files in our local mirror is
`/modules/02packages.details.txt.gz`.  Let's take a look inside.


``` plain /modules/02packages.details.txt.gz
File:         02packages.details.txt
URL:          http://www.perl.com/CPAN/modules/02packages.details.txt
Description:  Package names found in directory $CPAN/authors/id/
Columns:      package name, version, path
Intended-For: Automated fetch routines, namespace documentation.
Written-By:   CPAN::Mini::Inject 0.33
Line-Count:   145223
Last-Updated: Tue, 12 Aug 2014 15:01:40 GMT

AAA::Demo                         undef  J/JW/JWACH/Apache-FastForward-1.1.tar.gz
AAA::eBay                         undef  J/JW/JWACH/Apache-FastForward-1.1.tar.gz
AAAA::Crypt::DH                    0.04  B/BI/BINGOS/AAAA-Crypt-DH-0.04.tar.gz
AAAA::Mail::SpamAssassin          0.002  S/SC/SCHWIGON/AAAA-Mail-SpamAssassin-0.002.tar.gz
AAAAAAAAA                          1.01  M/MS/MSCHWERN/AAAAAAAAA-1.01.tar.gz
AAC::Pvoice                        0.91  J/JO/JOUKE/AAC-Pvoice-0.91.tar.gz
AAC::Pvoice::Bitmap                1.12  J/JO/JOUKE/AAC-Pvoice-0.91.tar.gz
AAC::Pvoice::Dialog                1.01  J/JO/JOUKE/AAC-Pvoice-0.91.tar.gz
...
```

The format is pretty straightforward.  After a few header lines, we have one
line per package seen by the indexer.  The lines consist of three whitespace
separated columns of a package name, current package version (if the indexer found one),
and latest distribution containing it.  The AAC-Provoice and Apache-FastForward
distributions show us that each individual package within the distribution is
listed.  We could easily use `zgrep` to find packages that match a pattern.

```
$ zgrep -i tiny ~/Dropbox/minicpan/modules/02packages.details.txt.gz
Acme::Has::Tiny                   0.001  T/TO/TOBYINK/Acme-Has-Tiny-0.001.tar.gz
Acme::Module::Build::Tiny          0.0   D/DA/DAGOLDEN/Acme-Acme-Module-Build-Tiny-0.06.tar.gz
Acme::Tiny                        0.003  E/ET/ETHER/Acme-Tiny-0.003.tar.gz
...
```

This is a little long to type regularly.  A shell alias isn't appropriate as we
want to sandwich the provided input between zgrep and the path to the file.
Fortunately, a shell function will allow us to do this without much more
verbosity.

``` sh
function cpangrep {
    zgrep $* /home/yourusername/Dropbox/minicpan/modules/02packages.details.txt.gz
}
```

Dropping this line in your `.zshrc` or `.bashrc` will allow you to search
`02packages.details.txt.gz` with the `cpangrep` command.

```
$ cpangrep tiny | wc -l
21
$ cpangrep -i tiny | wc -l
344
$ cpangrep -i tiny
Acme::Has::Tiny                   0.001  T/TO/TOBYINK/Acme-Has-Tiny-0.001.tar.gz
Acme::Module::Build::Tiny          0.06  D/DA/DAGOLDEN/Acme-Acme-Module-Build
...
```

Since we use `$*` instead of `$1`, all arguments we give to the function are
passed on to zgrep.  This allows us to do things like search with or without
ignoring case on demand.

CPAN::Mini::Webserver
---------------------
[CPAN::Mini::Webserver](https://metacpan.org/pod/minicpan_webserver) provides a
script that launches a web server providing an interface to your local minicpan.
Usage couldn't be easier, install `CPAN::Mini::Webserver` then run
`minicpan_webserver`.  By default the server binds to port 2963 but you can
change this with the `--port` argument.

If you've used [search.cpan.org](http://search.cpan.org/) or
[metacpan](http://metacpan.org), there should be no surprises in how to navigate
around the site.  The
[documentation](https://metacpan.org/pod/minicpan_webserver) has information on
a few things you can plug in to your `.minicpanrc` to enable things like full
text indexing.

Here are a few screenshots of [CPAN::Mini::Webserver](https://metacpan.org/pod/minicpan_webserver) to wet your appetite.

{% img /assets/2014/minicpan/index.png Index View %}
{% img /assets/2014/minicpan/search_results.png Search Results %}
{% img /assets/2014/minicpan/author_view.png Author View %}
{% img /assets/2014/minicpan/dist_view.png Distribution View %}
{% img /assets/2014/minicpan/module_view.png Module View %}

