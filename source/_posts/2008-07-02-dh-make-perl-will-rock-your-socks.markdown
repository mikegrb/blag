--- 
layout: post
title: dh-make-perl will rock your socks
wordpress_id: 123
wordpress_url: http://michael.thegrebs.com/?p=123
date: 2008-07-02 15:38:04 -04:00
comments: yes
tags: geek perl debian ubuntu deb
---
<code>dh-make-perl</code> is the most awesome Debian package /ever/.

<code>dh-make-perl --cpan Some::Module --build
sudo dpkg -i libsome-module-0.1-1_all.deb</code>

Done.

<strong>Dependencies</strong>

If you have <code>apt-file</code> installed and Some::Module requires Lib::Foo for which a Debian package is available, the dependancy will automatically be created.  If Lib::Foo does not have a Debian package already available, you will likely  need to manually run <code>dh-make-perl</code> on Lib::Foo first.

I haven't seen the <code>apt-file</code> trick mentioned elsewhere.  Honestly when someone mentioned it on IRC I didn't believe him.  Sure enough, looking at the source for <code>dh-make-per</code>l revealed that it does indeed check apt-file for each module that Some::Module lists as required in the <code>META.yml</code>.

<strong>Why?</strong>

Now dpkg/apt know that you have Some::Module installed.  If an official package for Some::Module comes out, it will likely have the same name and if it is for a newer version of Some::Module aptitude upgrade will automagically upgrade you to it.  The real win is ease of cleanly uninstalling though. How many times have you found what you thought was the perfect module for task XYZ and installed it.  Only to find that it isn't so hot 5 minutes after beginning to use it.  Making sure '<code>make uninstall</code>' really uninstalled every thing can be a pain.
