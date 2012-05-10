--- 
layout: post
title: screen copy mode can be used to copy/paste
wordpress_id: 124
wordpress_url: http://michael.thegrebs.com/?p=124
date: 2008-07-10 12:38:48 -04:00
comments: yes
tags: geek screen tips
---
I'm aware of many people that use GNU Screen's copy mode to scroll back through terminal history but don't actually use copy mode for copying text for later pasting.  I was one of those people myself for some time.  Screen supports some pretty nifty copy/paste tricks but a few basic key strokes will get you started.

<strong>Entering Copy Mode and Scrolling</strong>

By default, enter copy mode with <code>CTRL+a</code> then <code>ESCAPE</code>.  You can use vi like commands to navigate through the scollback buffer.  The arrows and <code>PAGE UP/DOWN</code> should work as well.  A few useful commands some may be unfamiliar with:
<ul>
	<li><code>M</code> - jumps to the middle visible line</li>
	<li><code>NN%</code> - jumps to the specified percentage in the buffer (0 - start, 100 - end</li>
	<li><code>g</code> - jumps to the beginning of the buffer</li>
	<li><code>G</code> - jumps to the end of the buffer</li>
</ul>

These keys are even useful when you aren't using copy mode to copy/paste text.

<strong>Copying Text</strong>

Once the cursor is at the beginning location, press <code>SPACEBAR</code> to set your first mark.  Next navigate to the ending position and hit it again.  The second <code>SPACEBAR</code> will set your end mark and exit copy mode.  One neat and often useful feature is selecting a rectangle on the screen rather than full lines.  Use <code>c</code> and <code>C</code> to set the left and right column margins to the cursor's current location.

<strong>Pasting</strong>

Pasting is easy, just hit <code>CTRL+a</code> to activate screen then <code>]</code> to paste.

<strong>There's More!</strong>

There are loads more options such as multiple copy buffers, the ability to append marked text to the buffer rather than replacing it, etc.  Check out the man page for more screen goodness.
