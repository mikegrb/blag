--- 
layout: post
title: Rotate through Screen Windows
wordpress_id: 122
wordpress_url: http://michael.thegrebs.com/?p=122
date: 2008-06-26 13:18:01 -04:00
comments: yes
tags: geek screen tips
---
A new command in screen version 4.00 is the <code>idle</code> command.

<code>idle time command</code>

Executes screen command, <code>command</code> when idle for <code>time</code> seconds. E.g. to rotate through screen windows with a 3 second interval:

<code>idle 3 next</code>

To cancel, <code>idle 0</code>
