--- 
layout: post
title: Thermostat RRD display with Javascript
date: 2012-05-25 08:50:21 -04:00
tags: geek house eco rrd js
comments: yes
---
In the [last post](/2012/05/20/tweeting-thermostat/) I described my new [Filtrete 3M-50 thermostat](http://www.homedepot.com/buy/electrical-home-automation-security-home-automation-climate-control/filtrete-7-day-touchscreen-wifi-enabled-programmable-thermostat-with-backlight-182800.html) and my data collection using a [script](http://central.isaroach.com/wiki/index.php/Perl#Poller) from a [wiki](http://central.isaroach.com/wiki/index.php/Main_Page).  I wanted an easy way to get values for datapoints on the graphs and have been looking for a use for [javascriptRRD](http://javascriptrrd.sourceforge.net/) since discovering it a year or more ago.

I ended up having to modify the library slightly to get it to pass the yaxes option on to flot.  My source is over on [github](https://github.com/mikegrb/jsrrdthermostat).

<img src="/images/2012/jsthermrrd.png" />

You can see the real time data [over here](http://thegrebs.com/~michael/thermostat/jsrrd.html).

