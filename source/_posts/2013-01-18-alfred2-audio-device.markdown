--- 
layout: post
title: Alfred 2 Workflow for Audio Device Selection
date: 2013-01-18 17:12:32 -04:00
tags: alfred geek perl mac
comments: yes
---

[Alfred V2](http://blog.alfredapp.com/2012/12/05/alfred-v2-coming-soon/) has a great new feature called [workflows](http://blog.alfredapp.com/2012/12/14/v2-sneak-peek-workflows/).  I've been playing with a few others wrote and had ported my old custom commands to workflows but was looking for something to really make use of their power.


<img src="/assets/2013/old_busted.png" width="337" height="347" alt="Changing OSX Audio device from menubar" style="float: right" />
Changing the selected audio output device was just the thing to implement as a workflow.  OS X has a nice shortcut for doing this without heading to system preferences.  Option clicking the speaker in the menu bar well let you change the input or output device, but I wanted to do it easily from the keyboard.


The 'Script Filter' option under the input menu is the magic for this workflow.  It allows a script to output a list of items for display and selection in the Alfred GUI.  You get Alfred's great predictive auto complete which makes selecting a device a breeze.

<img src="/assets/2013/select.png" width="620" height="345" alt="Selecting output audio device in Alfred" />

Output via Growl or Notification Center provides feedback of the completed action.

<img src="/assets/2013/growl.png" width="353" height="178" alt="Growl confirmation"/>

The workflow is pretty simple in Alfred's workflow editor, it ends up looking like this:

<img src="/assets/2013/workflow.png" width="832" height="548" alt="Alfred work flow" />

Alfred makes sharing workflows insanely easy by throwing all the necessary files for each workflow in a dedicated directory.  Right clicking a workflow in Alfred gives an export workflow option which creates a zip file of this directory with the '.alfredworkflow' extension.

[Grab SwitchAudio.alfredworkflow](/assets/2013/SwitchAudio.alfredworkflow)

The heavy lifting is done by [switchaudio-osx](https://github.com/deweller/switchaudio-osx) by deweller on GitHub with a simple perl glue script to pass data back and forth between Alfred and switchaudio-osx.

``` perl
#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

my $action = shift || 'list';
my $direction = shift || 'output';

if ($action eq 'list') {
    my $devices = get_possibilities($direction);
    print qq{<?xml version="1.0"?>\n<items>\n};
    print output_device($_) for @$devices;
    print "</items>\n";
}

if ( $action eq 'set' ) {
    my $device = shift;
    print set_device($direction, $device) . "\n";
}

sub get_possibilities {
    my $direction = shift;
    my @devices;
    open( my $fh, '-|', $FindBin::Bin . '/SwitchAudioSource',
        '-at', $direction );
    while ( my $line = <$fh> ) {
        chomp $line;
        $line =~ s/ \(\Q$direction\E\)$//;
        push @devices, $line;
    }
    close $fh;
    return \@devices;
}

sub set_device {
    my ( $direction, $device ) = @_;
    open( my $fh, '-|', $FindBin::Bin . '/SwitchAudioSource',
        '-t', $direction, '-s', $device );
    my $output = join "\n", <$fh>;
    close $fh;
    return $output;
}

sub output_device {
    my $device = shift;
    ( my $device_no_space = $device ) =~ tr/ /_/;
    return qq{<item arg="$device" uid="$device_no_space"><title>$device</title><subtitle/><icon>icon.png</icon></item>\n};
}
```
