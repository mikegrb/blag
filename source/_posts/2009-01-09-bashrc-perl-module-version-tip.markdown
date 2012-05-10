--- 
layout: post
title: ~/.bashrc Perl Module Version Tip
wordpress_id: 189
wordpress_url: http://michael.thegrebs.com/?p=189
date: 2009-01-09 11:41:12 -05:00
comments: yes
tags: geek perl tips bash
---
I often need to quickly check the version of a perl module currently installed.  A while back I got tired of running:

    $ perl -MPOE::Filter -E 'say $POE::Filter::VERSION'
    1.2357

So I added a quick function to .bashrc:

``` bash
pm-vers () {
    perl -M$1 -e "print \$$1::VERSION, \"\n\""
}
```

Now I just run:
    $ pm-vers POE::Filter
    1.2357


