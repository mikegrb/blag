--- 
layout: post
title: Adding a Datastore to an RRD File
wordpress_id: 81
wordpress_url: http://michael.thegrebs.com/2007/12/30/adding-a-datastore-to-an-rrd-file/
date: 2007-12-30 13:17:13 -05:00
comments: yes
tags: geek rrd perl
---
Mainly for personal future reference.

Adding a DS to a bunch of RRD files is a big pain,  RRD doesn't have any sort of native mechanism for doing this.  The usual procedure is exporting the RRD data to XML, creating a new rrd file with the old datastores plus your new ones, then importing the data back in from the XML.

A while back I needed to do this for a load of RRDs so I wrote a quick and dirty bash script for it.  Today I had reason to add a DS again but couldn't find my script.  A bit of googling was no help either, surely other people have this problem too?  I discovered Nicola Worthington's <a href="http://search.cpan.org/~nicolaw/RRD-Simple/lib/RRD/Simple.pm">RRD::Simple</a> contains an `add_source` method so a few moments in <a href="http://macromates.com/">TextMate</a> later we have:

``` perl
#!/usr/bin/perl

use strict;
use warnings;

use RRD::Simple();

my $rrd_path = "/path/to/dir/of/rrds/";
my @rrd_files = <$rrd_path/*.rrd>;

my $rrd = RRD::Simple->new();

for my $file (@rrd_files) {
    print "Processing $file...";
    $rrd->add_source($file, 'DS_name' => 'DERIVE');
    print " ok.\n";
}
```

