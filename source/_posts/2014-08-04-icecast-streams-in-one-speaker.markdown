---
layout: post
title: Listening to Icecast Streams in One Speaker
date: 2014-08-04 14:25:52 -04:00
tags: geek gallowaynow icecast sox
comments: yes
---

I run a site with two scanner feeds for my local town ([Gallowaynow.com](http://gallowaynow.com)). I regularly listen to both of these feeds when I'm not around the scanners supplying them.  How do you listen to two feeds that may be talking at the same time and make sense of anything? With [sox](http://sox.sourceforge.net/) the Swiss Army knoe of sound processing. By playing the two mono feeds out a single stereo device, the brain can easily deferenciate between the two sources.  This may not work very well from laptop speakers but works great from speakers with a few feet of seperation or headphones.  [sox](http://sox.sourceforge.net/) can easily handle modifying the streams  likes to work with files or piped streams so first we need to grab the icecast stream.

fIcy
====

[fIcy](http://www.thregr.org/~wavexx/software/fIcy/) is an open source suit of tools for grabbing icecast streams. It can do things like grab a stream and save it to mp3s when metadata changes, checkout [the examples](http://www.thregr.org/~wavexx/software/fIcy/#examples) on its site for some of the other neat things it can do.  Rather than invoke fIcy directly, I use fPls, included in the suite which can retry if the connection drops.  Invocation is fairly straight forward:

```
fPls -T 10 -L-1  http://gallowaynow.com:8000/stream.m3u -t
```
-T 10 waits ten seconds between reconnection attempts, -L-1 tells it to try indefenitly, next is the stream URL, and -t outputs the stream metadata to STDERR when it changes.

sox
===

sox is crazy flexible and can manipulate audio files in almost any way imaginable. See [the examples in the man page](http://sox.sourceforge.net/sox.html#DESCRIPTION) or [this blog post](http://www.thegeekstuff.com/2009/05/sound-exchange-sox-15-examples-to-manipulate-audio-files/) for just a sampling (heh, sampling) of the sort of things sox can do.  In our case we want to take a mono mp3 on STDIN and place that audio in just one channel of a stereo stream and then play it. We use the remix effect to accomplish this. Since transforming and then playing the audio is common, sox includes a play binary that takes all the same commands sox does but then plays the output.


```
play -q -t mp3 - remix 1 0

```

Remix takes a space separated list of input channels to be output on the positional output channel.  In this case, input channel 1 is output on the first channel, the second output channel uses the special input channel 0, silence.  For our second stream, we flip the numbers around to specify that the input be played on the second output channel.  You can also adjust the volume of the input channel in the output.  My actual command for my first stream is:

```
play -qV1 -t mp3 - remix 1v0.3 0
```

In this case we are attenuating the voltage of the signal by 70%.  2 instead of 0.3 would double volume.  This lets me adjust the streams for equivalent volume.

Putting it all Together
=======================

Piping the two commands together, we get:

```
fPls -T 10 -L-1  http://gallowaynow.com:8000/stream.m3u -t \
    | play -qV1 -t mp3 - remix 1v0.3 0
```

