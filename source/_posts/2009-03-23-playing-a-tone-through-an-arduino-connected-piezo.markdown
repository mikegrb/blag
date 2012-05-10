--- 
layout: post
title: Playing a Tone Through an Arduino Connected Piezo
wordpress_id: 214
wordpress_url: http://michael.thegrebs.com/?p=214
date: 2009-03-23 21:27:52 -04:00
comments: yes
tags: geek arduino piezo
---
I'm working on a top secret project, all I'll say is it involves the Arduino, Twitter, and the refrigerator, and needed to play a tone through a piezo connected to the Arduino.  I looked around and the closest I could find was <a href="http://www.arduino.cc/en/Tutorial/PlayMelody">a tutorial  that included code to play a melody</a>.

This wasn't quite what I wanted and the playTone function expects the notes and timing to be in global variables which makes the baby jesus cry.  The premise was simple though.  Take the period and divide by two then bring the output high then low for this amount of time, repeat to make up the desired duration. 

``` c
int pinSpeaker = 10;

void setup () {
    pinMode(pinSpeaker, OUTPUT);
}

void loop () {
    playTone(750, 500);
    delay(750);
}

// duration in mSecs, frequency in hertz
void playTone(long duration, int freq) {
    duration *= 1000;
    int period = (1.0 / freq) * 1000000;
    long elapsed_time = 0;
    while (elapsed_time < duration) {
        digitalWrite(pinSpeaker,HIGH);
        delayMicroseconds(period / 2);
        digitalWrite(pinSpeaker, LOW);
        delayMicroseconds(period / 2);
        elapsed_time += (period);
    }
}
```

This simple sketch plays a 500Hz tone for 750 mSec, pauses 750 mSec and repeats.  To use it in your sketch simply define `pinSpeaker` and set it for output, copy `playTone` to your sketch and call it with the duration in milliseconds and the frequency in hertz.

