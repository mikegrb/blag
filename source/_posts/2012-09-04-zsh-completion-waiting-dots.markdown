--- 
layout: post
title: ZSH Completion Waiting Dots
date: 2012-09-04 00:11:27 -04:00
tags: geek zsh shell
comments: yes
---
ZSH has some pretty nice tab completion but some of the completion modules can make things slow when you have a high latency conection.  This can be extra harsh for me as I have failure to complete beeps turned off so I'm not sure if it's still trying to complete or if there were no matches.  When reading some zshrc snippts on [Stack Overflow](http://stackoverflow.com) I came accross my favorite new snippit.

[This snippet](http://stackoverflow.com/a/844299) from [a paid nerd](http://stackoverflow.com/users/102704/a-paid-nerd) adds '...' output during completion that is replaced with the completion or removed once the completion engine is finished.

Here's the snippet:
``` sh
# http://stackoverflow.com/a/844299
expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
```
Also, get yourself in the habbit of including a comment with a url for stuff like this.  I once wanted to write a blog post about something I found somewhere and couldn't remember where I found it online!  I'll never make that mistake again.
