--- 
layout: post
title: No upstart Docs + asshole Canonical Employees = Fail
wordpress_id: 133
wordpress_url: http://michael.thegrebs.com/?p=133
date: 2008-08-18 12:07:00 -04:00
comments: yes
tags: geek stupid support ubuntu
---
I was in need of a means to disable upstart scripts in /etc/event.d via some means other than getting rid of the file.  Since upstart has no documentation to speak of, I asked my buddy Google.

Google pointed me to the year old <a href="https://bugs.launchpad.net/upstart/+bug/94065">bug 94065 in launchpad</a>.  I added a quick 'me too' and subscribed to updates on the bug.  This was back in March.  Fast forward to last week and this arrives:
<pre>
** Changed in: upstart
      Target: 0.5 => None

-- 
Add non-destructive means to disable a job
https://bugs.launchpad.net/bugs/94065
You received this bug notification because you are a direct subscriber
of the bug.
</pre>

There is no mention of this change in bug meta-data on the launchpad site, or maybe I'm just not finding it since I lack the doctorate in navigating launchpad necessary to be able to use the site.  This prompted an update from the original reporter on the bug asking for more information:

<blockquote>
is there a disable method yet? i reported this initially over a year ago. (there may be, but since there's no upstart manpage on hardy, it's hard to know. :-)
</blockquote>

Now for the asshole fail:

<blockquote><a href="https://bugs.launchpad.net/~scott">Scott James Remnant</a> wrote on 2008-08-14: (permalink)

Does this bug report say that there is a disable method? Is it marked Fix Released?
No.</blockquote>

I'm not sure what Scott James Remnant &lt;scott@canonical.com&gt;'s roll at Canonical is but perhaps it should be modified to remove any tasks that involve interaction with the public?
