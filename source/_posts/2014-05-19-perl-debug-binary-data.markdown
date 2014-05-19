--- 
layout: post
title: In Perl, Debugging with Binary Data Structures
date: 2013-05-19 01:20:40 -04:00
tags: data geek perl dump debug
comments: yes
---

Perl has some really great tools for dumping datastructures when debugging. [Data::Printer](https://metacpan.org/pod/Data::Printer) by [GARU](http://onionstand.blogspot.com/) is a realitive new comer that's gained a tremendous following. Of course, everyone also knows [Data::Dumper](https://metacpan.org/pod/Data::Dumper), core since at least perl 5.5 in 2004. What do you do when you need to dump binary data though?

I recently had to do this for the first time so I went looking on the CPAN to see what was available. I found two modules that both made dumping binary data simple. [Data:HexDump](https://metacpan.org/pod/Data::HexDump) and a more recently updated [Data::HexDumper](https://metacpan.org/pod/Data::Hexdumper). Both have similiary simple usage:

```perl
use Data::Hexdumper;
use Data::HexDump;

my $binary_data = get_some_bin_data();

print hexdumper $data;
print hexdump $data;
```

I started with the much more configurable and more recent [Data::HexDumper](https://metacpan.org/pod/Data::Hexdumper). The only draw back was some of my data generated warnings when printing.  You could turn this off with either of:

```perl
print hexdumper (data => $binary_data, suppress_warnings => 0);
# or
print hexdumper $binary_data, { suppress_warnings => 0 };
```

but both were two much typing for a lazy Perl developer.  I ended up installing and switching over to [Data:HexDump](https://metacpan.org/pod/Data::HexDump).  This module has no configurable options but didn't generate warnings with my sample data.

For simple situations, [Data:HexDump](https://metacpan.org/pod/Data::HexDump) seems a suitable choice at 4k. Even you want control over the output, and there is lots of control offered, [Data::HexDumper](https://metacpan.org/pod/Data::Hexdumper) does it in only 13.6K.

Here's sample output for both, with default options for [Data::HexDumper](https://metacpan.org/pod/Data::Hexdumper).

**Data::Hexdumper**

```
  0x0000 : B4 2D 81 35 D0 16 23 4C F4 ED 23 64 60 AB FC 37 : .-.5..#L..#d`..7
  0x0010 : 0C CA 60 C7 3F A2 58 75 53 CD 78 DF D3 0C 16 18 : ..`.?.XuS.x.....
  0x0020 : B7 CD 92 95 A2 E1 54 3A F3 89 7A 88 89 28 05 4A : ......T:..z..(.J
  0x0030 : 1B 18 C9 2F 61 8D 49 83 E6 2B 18 96 A6 40 8F BA : .../a.I..+...@..
  0x0040 : 44 0D A4 02 1E D2 01 E3 9F 1C 63 47 94 80 9B 74 : D.........cG...t
  0x0050 : 0C D1 63 46 0A 89 B5 1F F3 A7 68 4C 14 1B E6 2E : ..cF......hL....
```

**Data::HexDump**

```
          00 01 02 03 04 05 06 07 - 08 09 0A 0B 0C 0D 0E 0F  0123456789ABCDEF

00000000  B4 2D 81 35 D0 16 23 4C - F4 ED 23 64 60 AB FC 37  .-.5..#L..#d`..7
00000010  0C CA 60 C7 3F A2 58 75 - 53 CD 78 DF D3 0C 16 18  ..`.?.XuS.x.....
00000020  B7 CD 92 95 A2 E1 54 3A - F3 89 7A 88 89 28 05 4A  ......T:..z..(.J
00000030  1B 18 C9 2F 61 8D 49 83 - E6 2B 18 96 A6 40 8F BA  .../a.I..+...@..
00000040  44 0D A4 02 1E D2 01 E3 - 9F 1C 63 47 94 80 9B 74  D.........cG...t
00000050  0C D1 63 46 0A 89 B5 1F - F3 A7 68 4C 14 1B E6 2E  ..cF......hL....
```
