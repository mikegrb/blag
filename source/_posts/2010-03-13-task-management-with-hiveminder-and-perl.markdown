--- 
layout: post
title: Task Management with Hiveminder and Perl
wordpress_id: 247
wordpress_url: http://michael.thegrebs.com/?p=247
date: 2010-03-13 18:08:25 -05:00
comments: yes
tags: geek perl hiveminder
---
<p>This is how I manage my tasks with <a href="http://hiveminder.com/">Hiveminder</a> on a weekly basis and the Perl script that helps me do it.  I don't really expect the Perl script to be useful to anyone as-is but portions of it may be useful to others, as well as the general work flow, so I've decided to share them.</p>

<p>At <a href="http://www.linode.com/">Linode</a> we have a wiki page where we list 5 or more tasks we wish to accomplish during the week.  There is a heading for each employee and below the heading we place our tasks.   Throughout the week we can add additional tasks or mark existing ones as done.</p>

<p>I've used <a href="http://hiveminder.com/">Hiveminder</a> for some time.  When we started the weekly task lists at <a href="http://www.linode.com/">Linode</a> I found that taking a few minutes to figure out which tasks I wish to complete in the coming week works quite well for me.  I started marking these tasks with the 'week' tag in <a href="http://hiveminder.com/">Hiveminder</a>.  I quickly ended up writing a perl script, <a href="http://thegrebs.com/~michael/tasks/week.txt">week.pl</a>, to help me manage hem.</p>

<!-- more -->

<h3>My Weekly Workflow</h3>

<p>First thing Monday morning I run:</p>

	$ week.pl report

<p>This prints a report with two sections.  The first section lists tasks that currently have the 'week' tag with a line through the task ID if it is completed.  This gives me a nice summary of what I planned on accomplishing the previous week and how I did.  The second section lists all of my tasks currently visible in <a href="http://hiveminder.com/">Hiveminder</a>.  I hide tasks that I know I'm not going to work on in the next few weeks so this list is usually no more than 20 or 30 items.</p>

<img src="http://thegrebs.com/~michael/tasks/report.png" height="260" width="334" alt="Sample report Image"/>

<p>I take this report into the Monday morning meeting with me.  During the meeting, I'll glance over this list and select items for the upcoming week.  I also use this page to take notes on during the meeting, writing down any new tasks that come up in the meeting.</p>

<p>After the meeting, I add any new tasks generated in the meeting that I won't be working on this week to <a href="http://hiveminder.com/">Hiveminder</a>.</p>

	$ todo.pl braindump

<p>`todo.pl` comes from <a href="http://search.cpan.org/~alexmv/App-Todo-0.97/bin/todo.pl">App::Todo</a>, a command line <a href="http://hiveminder.com/">Hiveminder</a> interface.  The braindump command launches $EDITOR where I add new tasks, one per line.  The <a href="http://hiveminder.com/help/reference/tasklists/braindump.html">braindump syntax</a> allows for specifying tags, setting priorities, and other things as well.</p>

<p>Next, I prepare the task list for the upcoming week:</p>

	$ week.pl edit
	Carry over the following tasks?
	bring about world peace (y or n) [default y] y
	write some awesome pre
	do some other cool stuff
	create practical cold fusion (y or n) [default y] n
	return library book

<p>The `edit` command iterates over each task tagged with 'week' if  the task is not marked completed. It prompts whether or not I wish to carry the task over to this week (leave the tag). Any tasks marked completed have the tag removed automatically.</p>

	$ week.pl add
	Created:
	        #YRVK write an awesome report for Tom [week dev]
	        #YRVL test some new stuff for deployment [week admin]

<p>The `add</tt` command works the same as todo.pl's braindump command except the 'week' tag is automatically applied to the newly created tasks.  The full braindump syntax is available for specifying other properties of the tasks.</p>

	$ week.pl update https://path.to.trac/wiki/Tasks/2010-03-15
	Sup dawg, I heard you like tasks so I did ur shit for you

<p>The `update` command grabs my tasks tagged with 'week' and formats them one per line started with ' * ', a wiki bullet list.  It grabs the current wiki page, finds my heading, substitutes the formatted task list under the heading, and submits the change.  It also stores the path given in the YAML config file.</p>

	$week.pl go

<p>This opens the stored URL for this week's tasks wiki page in my default browser, allowing me to confirm week.pl did what it's supposed to.</p>

<p>Later in the week once I've done something:</p>

	$ week.pl done tom
	#YH7T bring about world peace [dev week]
	#YRVL test some new stuff for deployment [week admin]
	[DONE] #YRVK write an awesome report for Tom [week dev]

<p>This retrieves the task(s) tagged 'week' that are not marked completed containing the given string.  If there was only one match, the script marks it as done and then outputs the current state of tasks tagged 'week'.</p>

	$ week.pl update
	Sup dawg, I heard you like tasks so I did ur shit for you

<p>Same as `update` before, except when no URL is given, the URL is read from the configuration file.  This way I only need to worry about the URL once per week, the first time I update for the week.</p>

<h3>Conclusion</h3>

<p>So there you have it.  If you are also using <a href="http://hiveminder.com/">Hiveminder</a>, maybe aspects of my work flow will make sense for you and pieces of the Perl script may be useful.  If you aren't using <a href="http://hiveminder.com/">Hiveminder</a>, maybe you will be inspired to check it out.  I use michael@thegrebs.com on <a href="http://hiveminder.com/">Hiveminder</a> in case you feel the need to assign me a task or wish to gift me another year of Hiveminder Pro ;)</p>

<a href="http://thegrebs.com/~michael/tasks/week.txt">week.pl</a>
