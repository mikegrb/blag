--- 
layout: post
title: Net::Abuse::Utils v0.10 Released
wordpress_id: 154
wordpress_url: http://michael.thegrebs.com/?p=154
date: 2008-12-28 23:23:04 -05:00
comments: yes
---
I just released Net::Abuse::Utils v0.10 to CPAN.  If you can't wait, grab it <a href="http://thegrebs.com/~michael/modules/Net-Abuse-Utils-0.10.tar.gz">here</a>.

If you haven't heard of this module before, see this <a href="http://thegrebs.com/ip-info/">online example</a> of some of the data that can be returned.  Online docs are available as well at <a href="http://search.cpan.org/~mikegrb/Net-Abuse-Utils/lib/Net/Abuse/Utils.pm">search.cpan.org</a>.

From the Changes file:
<ul>
	<li>New get_domain function that converts host name to domain name</li>
	<li> Memoize support though commented out by default, enable by 
	  uncommenting the following two lines in `lib/Net/Abuse/Utils.pm`<br />
``` perl
# use Memoize;
# memoize('_return_rr');
```
	  A future version will likely allow Memoization via an export tag.</li>
</ul>

The `get_domain` function is fairly spiffy taking a host name like 'michael.thegrebs.com' and turning it into the domain name, 'thegrebs.com', but with proper recognition of second level zones like .co.uk.

The Memoization support is weak and I almost removed it but decided to leave it in but commented out for this release.  It speeds up batch processing of large quantities of requests fairly well.  Processing a days worth of spam used to take an average of 5 minutes and is now down to a minute and a half.  This is quite a bit more increase than I expected as I am using bind with heavy local caching.

There were a few more changes mostly related to distribution related stuff, see <a href="http://git.thegrebs.com/?p=Net-Abuse-Utils">git</a> for the full gory details.

Not a horribly significant release but it's been a while since the last one and I wanted to get `get_domain` out there.
