--- 
layout: post
title: Local Growl Notifications from Remote Irssi
wordpress_id: 323
wordpress_url: http://michael.thegrebs.com/?p=323
date: 2011-06-12 00:50:05 -04:00
tags: perl irssi ssh
comments: yes
---
<strong>What I've tried, What I want</strong>

Skip to the next section if you just care about the end result.  In the past, I've had my remote <a href="http://irssi.org/">Irssi</a> client send UDP <a href="http://growl.info/">Growl</a> packets to my static home IP that were then forwarded to the broadcast address on the local network.  This worked great and allowed me to get Growl notifications on which ever computer I happened to be sitting at.  These days, I'm always on my laptop, even when sitting at another computer (<a href="http://www.abyssoft.com/software/teleport/">Teleport</a> for the mega win).

I wanted a solution that would allow me to receive Growl notifications without having to forward any ports and no matter what the public IP for my laptop may be.  I use <a href="http://beta.metacpan.org/module/App::PersistentSSH">App::PersistentSSH</a> to maintain a persistent SSH control master connection to my <a href="http://www.linode.com/">Linode</a> so the ideal solution uses a reverse tunnel over this connection to get the notifications too my laptop.

<strong>My Current Solution</strong>
<ul>
<li>Added <code>--ssh_opts -R 127.0.0.1:22992:127.0.0.1:22</code> to my <a href="http://beta.metacpan.org/module/App::PersistentSSH">App::PersistentSSH</a> command line.  This connects localhost:22992 on my Linode to port 22 on my laptop.</li>
<li><a href="https://github.com/mikegrb/irssi-scripts/blob/master/local-growl.pl">local-growl.pl</a> -- an Irssi script that uses growlnotify to send growl notifications</li>
<li><a href="https://github.com/mikegrb/irssi-scripts/blob/master/growlnotify.pl">growlnotify.pl</a> -- an ssh proxy for growlnotify, passes it's arguments to growlnotify on a remote system via ssh</li>
</ul>

Simple push growl notifications from my <a href="http://www.linode.com">Linode</a> -> my MacBook Air whenever it is online.  The scripts and an irssi.png to use in the notifications are available on <a href="https://github.com/mikegrb/irssi-scripts">GitHub</a>.

Configuration for local-growl.pl is via Irssi's in built settings, type `/set growl` to see a list of possibilites:
```
[local-growl]
growl_enabled = ON
growl_growlnotifypath = /home/michael/bin/growlnotify
growl_image_path = /Users/mgreb/Documents/irssi.png
growl_show_hilights = ON
growl_show_private_messages = ON
growl_sticky = OFF
```

Configuration for growlnotify.pl is via a set of config variables near the top:
``` perl
my $ssh_host    = 'localhost';
my $ssh_port    = 22992;
my $ssh_user    = 'mgreb';
my $growlnotify = '/usr/local/bin/growlnotify';
```
Hopefully you will find this useful.

