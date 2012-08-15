--- 
layout: post
title: Syncing zsh named directories
date: 2012-08-06 22:45:21 -04:00
tags: geek zsh dropbox sync shell
comments: yes
---
One of my most used features of zsh is [named directories](http://zsh.sourceforge.net/Guide/zshguide02.html#l20).  I keep my dotfiles synced across multiple machines via [Dropbox](http://db.tt/InZto9O) (referral link) and a Makefile that creates symlinks automagically.

My named directories start with ~ for my home directory so they need to exist for expansion to work properly and not output errors when I log in.  When I first implemented syncing I added this check with a very simple test:

<!-- more -->

``` sh
[[ -d ~/Dropbox/wiki           ]] && wiki=~/Dropbox/wiki
```
One line like this isn't too bad but when you have 30, it gets a little silly looking.

I finally took the time to sit down and read the docs on zsh [associative arrays](http://zsh.sourceforge.net/Guide/zshguide05.html#l122) and whipped up a much better solution.

``` sh
typeset -A NAMED_DIRS

NAMED_DIRS=(
    bin      ~/Dropbox/Documents/bin
    docs     ~/Dropbox/Documents
    lbin     ~/Documents/bin
    wiki     ~/Dropbox/wiki
    dot      ~/Dropbox/Documents/dotfiles
    octo     ~/Dropbox/Documents/octopress
)

for key in ${(k)NAMED_DIRS}
do
    if [[ -d ${NAMED_DIRS[$key]} ]]; then
        export $key=${NAMED_DIRS[$key]}
    else
        unset "NAMED_DIRS[$key]"
    fi
done
```

The unset isn't necessary here for the base functionality.  I had another problem.  With 30 or 40 named dirs, some belonging to projects that I might not have looked at in 6 months and suddenly need to come back to, it's hard to remember the name I gave for a directory.  I added an lsdirs function that lists just the named directories that existing on the machine I'm on.

``` sh
function lsdirs () {
    for key in ${(k)NAMED_DIRS}
    do
        printf "%-10s %s\n" $key  ${NAMED_DIRS[$key]}
    done
}
```

This gives me nice easy to read output with both the names and the full path.

This blog post is more future reference for myself but perhaps it may be useful to you.

For those interested, here is the Makefile I use:

{% include_code 2012/Makefile lang:makefile %}
