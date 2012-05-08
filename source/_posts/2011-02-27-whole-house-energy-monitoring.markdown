--- 
layout: post
title: Whole House Energy Monitoring
wordpress_id: 277
wordpress_url: http://michael.thegrebs.com/?p=277
date: 2011-02-27 19:18:20 -05:00
comments: yes
tags: geek electronics electricity money green eco
---

I placed an order for a <a href="http://www.theenergydetective.com/ted-5000/features">TED 5000</a> on February 
10th. The <em>TED 5000</em> is a whole house energy monitor -- a kill-a-watt for the whole house.  I've spent a lot 
of time reading about the products available in this space.  I've looked at about 10 products for whole house 
energy monitoring and three jump to the top.  The <a href="http://www.wattvision.com/">wattvision</a>, <a 
href="http://www.powerhousedynamics.com/content/solutions">PowerHouse Dynamics's eMonitor</a>, and the <a 
href="http://www.theenergydetective.com/ted-5000/features">TED 5000</a>.

<a href="/assets/2011/wattvision-analog-sensor-beta.jpg"><img 
class="alignright" title="wattvision-analog-sensor-beta" 
src="/assets/2011/wattvision-analog-sensor-beta-300x168.jpg" alt="" 
width="300" height="168" /></a>

<!-- more -->

The <a href="http://www.wattvision.com/">wattvision</a> (~$250) most closely 
resembles the TED in terms of price and features.  The wattvision uses an optical sensor that counts the rotation 
of the disk in the utility meter.  This sensor is connected to the device, which is powered by an AC adapter and 
sends the data to wattvision's servers via your home wifi network.  This is the easiest to install, but would 
require running the sensor cable from the outside to inside. Additionally, all data is sent to wattvision's 
servers.  I'd also need to subscribe to wattvision's <a href="http://www.wattvision.com/info/pricing">$8.99/month 
service</a> for the other features I want (like API access.)

<img class="alignright" title="powerhouse dynamics eMonitor" src="/assets/2011/Picture29-300x276.png" alt="" width="300" height="276" />

The <a href="http://www.powerhousedynamics.com/content/solutions">eMonitor</a> (starting around $688 for 12 circuits) is something I just recently discovered.  Really, this is my ideal solution: for <a href="http://www.smarthome.com/90428/PowerHouse-Dynamics-eMonitor-44-Intelligent-Residential-Power-Usage-Monitor/p.aspx">$1,277</a>, you get the necessary equipment for monitoring the power feed plus 44 individual breakers.  This gives a much better view of where your power consumption is going.  Per-circuit monitoring also enables nifty alerts -- an SMS for power draw in the kids room after school starts on a week day, or if the compressor on the fridge is running longer than normal (time to clean the coils, etc.) I just can't justify the expense at $1,277.  The price is certainly reasonable for what you are getting, but there is no way the wife would approve the purchase :/

<img class="alignright size-full wp-image-285" title="ted-5000-g" src="/assets/2011/ted-5000-g.png" alt="" width="265" height="265" />

<a href="http://www.theenergydetective.com/ted-5000/features">The Energy Detective</a> (TED, ~$200) from Energy Inc provides full house consumption monitoring like the wattvision.  Unlike the wattvision, the data is stored and served from a gateway device on your home network.  Two current transformers go around the two lines for the incoming split phase feed.  These are connected to a box, which is installed next-to-or-inside the breaker panel. The breaker panel is powered and communicates via a connection to a breaker on each phase.  The gateway is installed elsewhere in the house and plugs into an outlet for power and communication with the current sensor, and via Ethernet to serve its precious data up.

So, February 10th I finally got approval from the wife to order the TED and purchased the <a href="http://www.theenergydetective.com/ted5000-g">TED 5000-G</a> with overnight shipping. It arrived as expected on the 11th and I was eager to install it.  A coworker (also interested in the TED,) came over for dinner and to help out with the installation.  I was too excited to wait for his arrival and finished the install before he got there ;-).

It's now February 27th and I still don't have a working TED system.  The gateway I was originally shipped has a defective Ethernet port. It's already been to Energy Inc and back and is <span style="text-decoration: underline;">still</span> defective.  They finally agreed to ship me a replacement gateway on the 25th but sent it with 2nd day shipping, which has the same transit time as ground (just more expensive.) The new unit should arrive March 1st.

<a href="/assets/2011/TED5000-display.png"><img src="/assets/2011/TED5000-display-e1298852839843-133x150.png" alt="" title="Optional TED Display" width="133" height="150" class="size-thumbnail wp-image-318" /></a>

I'm quite eager to get things up and running, and anticipate no problems once I have a working gateway. The most common issue people run into is excessive noise or attenuation of the <a href="http://en.wikipedia.org/wiki/Power_line_communication">power line communications</a> (PLC) signal between the sensor and gateway. The forums seem to be full of people with lots of grief around this issue. The gateway does contain a <a href="http://en.wikipedia.org/wiki/Zigbee">ZigBee</a> transceiver but that is for communication with the <a href="http://www.theenergydetective.com/additonal-ted-5000-display">optional wireless display</a>. Some have questioned switching from PLC to <a href="http://en.wikipedia.org/wiki/Zigbee">ZigBee</a> for the current data but a device inside the metal breaker box would have a hard time getting any sort of RF signal out, and PLC seems the most logical solution (even with it's inherent issues.)  Of course, this is easy for me to say since I don't anticipate having any issue with PLC. I can see a clear ~3-4Vpk signal on the zero crossing of the A/C at the outlet I plan to install the gateway:

<img src="/assets/2011/plc_w_ac.png" alt="AC with TED MCU transmissions" width="320" height="234" />

I have another blog post in the works documenting my seemingly unending issues with the other half of the TED solution: the support staff and engineers backing the product. To be fair, the support staff is 1:2 -- the second guy I spoke to there was great, but I'm pretty sure their engineers shouldn't be allowed to know customers even exist, let alone talk to them on the phone. But, this is a story for my next blog post.
