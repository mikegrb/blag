---
layout: post
title: Taking CPAN With You
date: 2014-08-08 22:03:32 -04:00
tags: geek perl cpan dropbox minicpan
comments: yes
---

[{% img right /assets/2014/ione.jpg Ione, OR %}](http://www.panoramio.com/photo/11290089)

[CPAN](http://en.wikipedia.org/wiki/CPAN) is THE killer feature for Perl. One
problem you may have from time to time due to it's online nature is availability
issues.  How do you install CPAN modules from a plane, train, or automobile
without wifi? Or from the middle of nowhere in Oregon ([Ione, OR](http://en.wikipedia.org/wiki/Ione,_Oregon))? Or timely install Moose and
it's dependencies from a dial-up connection in the middle of the deserted
Oklahoma plains ([Leedey, OK](http://en.wikipedia.org/wiki/Leedey,_Oklahoma)).
Well, my fellow perler, I have been to these places forgotten by the Internets,
and I have installed CPAN modules with impunity.

CPAN::Mini
==========
[CPAN::Mini](https://metacpan.org/pod/CPAN::Mini), driven by the included
[minicpan](https://metacpan.org/pod/distribution/CPAN-Mini/bin/minicpan),
creates a local mirror of CPAN containing only the latest non-developer release
of every distribution on CPAN.  With [CPAN::Mini](https://metacpan.org/pod/CPAN::Mini) you
too can install CPAN modules with impunity from exotic locations.  But just how
much disk space must you dedicate for such awesomeness? My mirror is currently
just under 3 GB.

Start by installing CPAN::Mini with your CPAN client of choice:

```
$ cpanm CPAN::Mini
$ # or
$ cpanp install CPAN::Mini
$ # or
$ cpan CPAN::Mini

```

Now you need a config file in ```~/.minicpan```.

``` plain ~/.minicpanrc
local:   ~/Dropbox/minicpan
remote: http://cpan.hexten.net/
also_mirror: indices/ls-lR.gz
skip_perl: 1
```

These options should be fairly self-explanatory.  Check out the
[CPAN Mirrors](http://mirrors.cpan.org/) site to find a healthy mirror in your region
for the second line. Now, just run ```minicpan``` and wait.  Periodically,
you'll want to run this command again to download new dists and delete old ones.
That's all it takes to be the owner of a shiny tiny local CPAN mirror.

Using Your Shiny New CPAN Mirror
================================
To use your new mirror, just specify the path to your CPAN::Mini mirror in your
CPAN client of choice.

cpanm
----------
For [cpanm](https://metacpan.org/pod/distribution/App-cpanminus/bin/cpanm) I
have an alias in my ```.zshrc```:

``` sh
minicpanm='cpanm --mirror ~/Dropbox/minicpan --mirror-only'
```
The same line should work in a ```.bashrc``` as is. Then, to install a new CPAN
module, just run ```minicpanm ACME::urmom```.

cpanp
-----
Run ```cpanp s edit``` and your editor will launch.  If the file you are in
isn't empty, skip to the next step. Now run ```cpanp s save``` to copy the
current configuration to the user config file and then run ```cpanp s edit```
again.

Find the ```hosts``` config and add your new entry at the beginning.

``` perl
    $conf->set_conf( hosts => [
          {
            'host' => '',
            'path' => '/Users/yourname/Dropbox/minicpan',
            'scheme' => 'file'
          }
          {
            'host' => 'ftp.cpan.org',
            'path' => '/pub/CPAN/',
            'scheme' => 'ftp'
          },
          {
            'host' => 'www.cpan.org',
            'path' => '/',
            'scheme' => 'http'
          },
    # ...
```

Save and exit your editor.

cpan
----
For ```cpan```, you use the interactive shell to update the configuration:

``` plain
$ cpan
cpan shell -- CPAN exploration and modules installation (v2.00)
Enter 'h' for help.

cpan[1]>  o conf urllist unshift file:///Users/yourname/Dropbox/minicpam
Please use 'o conf commit' to make the config permanent!


cpan[2]> o conf urllist
    urllist
    0 [file:///Users/yourname/Dropbox/minicpam]
    1 [http://cpan.erlbaum.net/]
    2 [http://cpan.mirror.clemson.edu/]
    3 [http://cpan.develooper.com/]
Type 'o conf' to view all configuration items


cpan[3]> o conf commit
commit: wrote '/Users/yourname/.local/share/.cpan/CPAN/MyConfig.pm'

```

Enjoy (Faster) CPAN Installs From Anywhere
==========================================

That's it! From here on out your disk speed and not your Internet connection,
or lack thereof, will be your throttle in your CPAN client of choice acquiring
distribution packages.
