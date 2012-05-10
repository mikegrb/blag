--- 
layout: post
title: Quick & Easy Temperature Logging with the Arduino
wordpress_id: 137
wordpress_url: http://michael.thegrebs.com/?p=137
date: 2008-11-02 23:29:50 -05:00
comments: yes
tags: geek arduino thermistor electronics
---
<strong>Basic Voltage Divider with a Thermistor:</strong>

<img src='http://thegrebs.com/~michael/old-stuff/old-png/therm-vd.png' alt='Thermistor Voltage Divider Schematic' class='alignleft' />

Typical voltage divider, matched would have made better sense but the thermistor was a random one salvaged from consumer electronics so I didn't know the value in advance.

Would work just fine like this with TP1 connected to an Arduino analog input and Vcc and GND connected.  Energy savings for the win though, connected the top of the divider (Vcc) to a digital pin on the Arduino.  Set the pin HIGH when you want to take a reading, LOW the rest of the time.  Now the divider is not consuming power when a reading isn't being taken.

<strong>Arduino Code</strong>

``` c
int pinDivEn   = 4;
int pinDivRead = 1;
int pinLED     = 13;

void setup() {
    Serial.begin(9600);
    pinMode(pinLED, OUTPUT);
    pinMode(pinDivEn, OUTPUT);
    Serial.println("READY");
}

void loop() {
    if (Serial.available() > 0) {
        digitalWrite(pinDivEn, HIGH);
        digitalWrite(pinLED, HIGH);
        delay(100);
        while (Serial.available() > 0)
            int serByte = Serial.read();
        Serial.println(analogRead(pinDivRead));
        digitalWrite(pinDivEn, LOW);
        digitalWrite(pinLED, LOW);
    }
}
```

pinDivEn is the divider enable pin (Vcc), pinDivRead is the analog input connected to TP1 in the divider, pinLED is is a digital pin with an LED that is lit while a reading is taken.

Once the Arduino boots it sends READY on the serial port at 9600 bps.  It then waits for any data to be available on the serial port, when bytes are available, the voltage divider is enabled, the LED is lit, the bytes on the serial port are consumed, the value of TP1 is read and then written to the serial port, the divider enable pin is brought back low and the led is extinguished.

<strong>Perl Code</strong>

``` perl
#!/usr/bin/perl

use strict;
use warnings;

use IO::Handle;
use Device::SerialPort;

my $dev = tie (*FH, 'Device::SerialPort', "/dev/tty.usbserial-A4001JwW")
    || die "Can't tie: $!";

$dev->baudrate(9600);
$dev->databits(8);
$dev->parity("none");
$dev->stopbits(1);

open (my $log, '>>', 'ohms.log') || die "can't open: $!";
$log->autoflush(1);

# wait for arduino to boot
while (1) {
    my $val = <fh>;
    last if $val;
}

print FH "1\n";
while (1) {
    my $val = </fh><fh>;
    next unless $val;
    chomp $val;

    my $vR2 = $val / 1023 * 5;
    my $vR1 = 5 - $vR2;
    my $i   = $vR1 / 1_000 * 1_000;
    my $R2  = $vR2 / $i;

    print $log time . ' ' . $R2 . "\n";
    # printf("V_R2=%.2fV, i=%.2fmA  R2=%.2fK&#8486;\n", $vR2, $i, $R2);

    sleep 10;
    print FH "1\n";
}
```

Opens the serial port, waits for something (the Arduino sending 'READY' but it pays no attention to what) on the serial port then every 10 seconds sends a 1\n to the Arduino prompting it to send a value.  The result of analogRead is an integer from 0 - 1023 so this is converted to a voltage.  The current through the divider is found allowing the resistance of the thermistor to be solved for.  The resistance and time are written to a space separated log file.  If the thermistor wasn't unknown it would make more sense to solve for the actual temp using the Steinhartâ€“Hart equation or similar and logging that rather than the resistance.

<strong>Sample log file entries</strong>

    1224349429 10.1195652173913
    1224349439 10.3666666666667
    1224349449 10.3666666666667
    1224349459 10.3666666666667
    1224349469 10.4943820224719
    1224349479 10.3666666666667
    1224349489 10.2417582417582

A few lines in a text file gets us a graph from the log file by way of GnuPlot:

    set term png transparent nocrop enhanced font "./arial.ttf" 9 size 800, 600
    set xdata time
    set timefmt "%s"
    set format x "%m/%d %H:%M"
    set xtics  rotate by -45
    set title "Thermistor Value"
    set xlabel "Date/Time"
    set ylabel "Resistance (kOhms)"
    set grid
    set output "ohms.png"
    plot \
        "ohms.log" using 1:2 title "10 sec interval readings" linecolor 2, \
        "ohms.log" using 1:2 title "Bezier fit curve" smooth bezier linecolor 4 lw 2, \
        10 title "77 F" lw 2 linecolor 1

<img src='http://thegrebs.com/~michael/old-stuff/old-png/ohms.png' alt='GnuPlot Graph of Time vs Resistance' class='alignnone' />

</fh>
