--- 
layout: post
title: Logging Apple Battery Data with Perl
date: 2013-06-02 06:04:45 -04:00
tags: data geek perl apple battery
comments: yes
---

Inspired by a [blog post](http://www.ifweassume.com/2013/08/the-de-evolution-of-my-laptop-battery.html) and the code that goes with it at [jradavenport/batlog](https://github.com/jradavenport/batlog), I created a perl script for logging Apple laptop battery details last August.

My script logs 11 values using ~67 bytes per record.  The oldest log I have begins 288 days ago and is 17,122,966 bytes for an average of 59.4 KB/day or 21 MB/year. The log is missing data points due to things like prolonged hibernation or sleep, theoretical max is around 35MB/year with 10 minute resolution.

The repo is on [GitHub](https://github.com/mikegrb/Battery-Logger).

Sample Graphs
--------------

A simple gnuplot script is included in the repo which produces the below graphs.

A couple days of output:
![Sample Battery Graph](/assets/2014/battery_health.png "Sample Battery Graph")

9 months of output:
![Sample Battery Graph 9 Months](/assets/2014/battery-9months.png "Sample Battery Graph 9 Months")

Things get a bit squashed at 9 months but the most interesting value over long durations, battery health, is clearly visible.

The Code
--------

Acquiring the data for this in Perl is exceedingly simple.  Apple provides a binary called ```ioreg``` for interacting with the I/O Kit Registry.  Asking for battery information with the arguments ```-rc AppleSmartBattery``` gets us almost JSON:

```
+-o AppleSmartBattery  <class AppleSmartBattery, id 0x100000203, registered, matched, active, busy 0 (0 ms), ret$
    {
      "TimeRemaining" = 36
      "AvgTimeToEmpty" = 65535
      "InstantTimeToEmpty" = 65535
      "ExternalChargeCapable" = Yes
      "FullPathUpdated" = 1401701615
      "CellVoltage" = (4193,4182,4193,0)
      ...
```

For our simple needs, massaging the data into proper JSON to use a parser is unnecessary.  A regex can cleanly capture the names inside the quotes and their values.  We then store the name value pairs in a hash.

``` perl
    if ( $line =~ m/"([^"]+)" = (.*)$/ ) {
        $data{$1} = $2;
    }
```

We create an array of the values we actually care about logging.  This is done near the beginning of the script, before running and parsing the output of ioreg.  If the amount of data was much larger, our simple parser could be made smarter to only store in the hash the values we care about. With only 39 values though, the slightly increased memory usage in the short lived cron job is preferable to the little bit of extra CPU to check if we want a value before storing it.

``` perl
my @logged = ( qw(
        CurrentCapacity MaxCapacity Pcnt CycleCount LifePcnt
        ExternalConnected IsCharging FullyCharged Temperature CellVoltage
) );
```

We can then take advantage of [hash slices](http://perldoc.perl.org/perldata.html#Slices) to write out just the values we care about:

``` perl
say $fh join( "\t", time, @data{@logged} );
```

```@data{@logged}``` becomes a list of the hash values for the keys earlier specified in ```@logged```.

The full script weighs in at only 28 lines of straight forward code. See just it [here](https://github.com/mikegrb/Battery-Logger/blob/master/logger.pl).

[GitHub Repo](https://github.com/mikegrb/Battery-Logger)