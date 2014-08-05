---
layout: post
title: Listening to Two Icecast Streams at Once
date: 2014-08-05 14:49:59 -04:00
tags: geek gallowaynow icecast sox tmux
comments: yes
---

I run a site with two scanner feeds for my local town, [Gallowaynow.com](http://gallowaynow.com), one for EMS & Fire and another less publicized one for PD. I regularly listen to both of these feeds when I'm not around the scanners supplying them.  How do you listen to two feeds that may be talking at the same time and make sense of anything? With [sox](http://sox.sourceforge.net/) the Swiss Army knife of sound processing. By playing the two mono feeds out each channel of a stereo device, the brain can easily deferenciate between the two sources.  This may not work very well from laptop speakers but works great from speakers with a few feet of seperation or headphones.  [sox](http://sox.sourceforge.net/) can easily handle modifying the streams  likes to work with files or piped streams so first we need to grab the icecast stream.

fIcy
====

[fIcy](http://www.thregr.org/~wavexx/software/fIcy/) is an open source suit of tools for grabbing icecast streams. It can do things like grab a stream and save it to mp3s when metadata changes, checkout [the examples](http://www.thregr.org/~wavexx/software/fIcy/#examples) on its site for some of the other neat things it can do.  Rather than invoke fIcy directly, I use fPls, included in the suite which can retry if the connection drops.  Invocation is fairly straight forward:

```
fPls -T 10 -L-1  http://gallowaynow.com:8000/stream.m3u -t
```

The ```-T 10``` waits ten seconds between reconnection attempts, ```-L-1``` tells it to try indefenitly, next is the stream URL, and ```-t``` outputs the stream metadata to STDERR when it changes.

sox
===

[sox](http://sox.sourceforge.net/) is crazy flexible and can manipulate audio files in almost any way imaginable. See [the examples in the man page](http://sox.sourceforge.net/sox.html#DESCRIPTION) or [this blog post](http://www.thegeekstuff.com/2009/05/sound-exchange-sox-15-examples-to-manipulate-audio-files/) for just a sampling (heh, sampling) of the sort of things sox can do.  In our case we want to take a mono mp3 on STDIN and place that audio in just one channel of a stereo stream and then play it. We use the remix effect to accomplish this. Since transforming and then playing the audio is common, sox includes a play binary that takes all the same commands sox does but then plays the output.


```
play -q -t mp3 - remix 1 0

```

Remix takes a space separated list of input channels to be output on the positional output channel.  In this case, input channel 1 is output on the first channel, the second output channel uses the special input channel 0, silence.  For our second stream, we flip the numbers around to specify that the input be played on the second output channel.  You can also adjust the volume of the input channel in the output.  My actual command for my first stream is:

```
play -qV1 -t mp3 - remix 1v0.3 0
```

In this case we are attenuating the voltage of the signal by 70%.  2 instead of 0.3 would double volume.  This lets me adjust the streams for equivalent volume.

play can take any filter chain you can pass to sox, another useful one here is silence trimming.  By adding ```silence -l 1 0.1 1% -1 2.0 1%``` to the end of our play command line, we can ask sox to trim any silence longer than 2 seconds to 2 seconds.  This may seem odd since we are listening in real time, not recording to a file, but it can help with minimizing delay.  Due to packet loss, slow connections, congested links, etc, the stream may stutter at times.  Since a large portion of the time the stream is silent, these stutters aren't noticable to the ear but it means playback was silenced for a few seconds and then resumed.  Any of these delays add up and eventually the audio you are listening to could be as much as 5 or 10 seconds behind the metadata printed by fIcy.  By telling sox it's okay to throw away silence, we can keep the audio caught up, minimizing delays.

We can put the commands together in simple shell scripts to simplify calling them.

``` sh ems.sh
#!/bin/sh

fPls -v -T 10 -L-1  http://gallowaynow.com:8000/stream.m3u -t \
    | play -qV1 -t mp3 - remix 1v0.3 0 silence -l 1 0.0 1% -1 2.0 1
```

``` sh pd.sh
#!/bin/sh

fPls -v -T 10 -L-1  http://gallowaynow.com:8000/gtpd.m3u -t \
    | play -qV1 -t mp3 - remix 0 1 silence -l 1 0.0 1% -1 2.0 1
```

tmux
====

Since the metadata is visible, it shows exactly which unit is talking and on which channel, running our two commands in a split tmux window makes since.  Especially if you have screen real estate to put this terminal out of the way somewhere.  We can script the creation of this window with a simple shell script.

``` sh tmux-streams.sh
#!/bin/sh

tmux new-session -d -s streams
tmux send-keys './ems.sh' 'C-m'
tmux select-window -t streams:0
tmux split-window -v
tmux send-keys './pd.sh' 'C-m'
tmux -2 attach-session -t streams

```

I like ```send-keys``` instead of specifying the command to run directly as it lets us ctrl+c the script and then rerun it with up-arrow enter.  Handy if I tweak the script or want to launch a fresh copy of stuff instead of having to destroy the tmux session.

![tmux screenshot](/assets/2014/tmux-streams.png "tmux screenshot") 
