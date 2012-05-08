--- 
layout: post
title: Geeky Weather Station Stuffs
wordpress_id: 141
wordpress_url: http://michael.thegrebs.com/?p=141
date: 2008-12-21 22:08:55 -05:00
comments: yes
tags: geek perl weather wxperl
---
<img src="http://michael.thegrebs.com/wp-content/uploads/2008/12/wxperl.png" alt="wxperl" title="wxperl" width="200" height="385" class="alignright size-full wp-image-176" />
<a href="http://weather.thegrebs.com/">http://weather.thegrebs.com/</a>

I recently received a nice Honeywell weather station.  It turns out they are actually manufactured by a company called Irox which also sells stations under it's own name but they seem to be more popular in Europe.  Being a geek, one of the first things I did was check out Linux or OS X support.  Unfortunately only one piece of software supports this weather station under Linux, <a href="http://www.weather-display.com/index.php">Weather Display</a>.  There Linux software is freeware but not open source and leaves quite a bit to be desired but at least it would talk to the weather station and collect data from it.

With a bit of Googling I found <a href="http://saratoga-weather.org/template/index.php">Saratoga Weather</a> which seems to be based on a template from <a href="http://www.carterlake.org/webtemplates.php">Carter Lakes</a>.  Unfortunately the PHP code is a bit of a mess with 43 separate php files all in a top level directory and including each other.  With a bit of work I was able to bend it to my will but every little change was a pain to accomplish.

I started slowly re-implementing things in Perl.  I found an <a href="http://www.tnetweather.com/wd-parser.php">online WD data-file parser</a> which greatly helped in figuring out what the fields in Weather Displays native log files meant.  Fast-forward a couple of weeks and I think things are pretty much done feature wise.  I lack NWS warning/watch/advisory notification, the thermometer image with today's information is still PHP generated, and I don't yet have a wind graph.  These last few details shouldn't take too much work when I get around to it.  I also have a few features the original lacks, graphs, a daily tweet with today's high/low, and sane code :p.

The information from my weather station is available online at <a href="http://weather.thegrebs.com/">http://weather.thegrebs.com/</a> and the source is available via git clone from http://git.thegrebs.com/git/wxperl.  You may also browse the repo via Git Web at <a href="http://git.thegrebs.com/?p=wxperl">http://git.thegrebs.com/?p=wxperl</a>.
