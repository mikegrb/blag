--- 
layout: post
title: Tweeting Thermostat 
date: 2012-05-20 18:45:05 -04:00
tags: perl geek house
comments: yes
---
<img src="/images/2012/3m-50.jpg" />

I recently replaced the thermostat in our new house with a [Filtrete 3M-50](http://www.homedepot.com/buy/electrical-home-automation-security-home-automation-climate-control/filtrete-7-day-touchscreen-wifi-enabled-programmable-thermostat-with-backlight-182800.html).  This thermostat has a wifi module and is available at your local Home Depot for $99.  I'd been aware of it for a while but had planned on purchasing the $250 [nest](http://www.nest.com/).  The turning point for me came one even as I was going to bed.  I was hot, the heat was running and I chose to turn the fan on instead of going downstairs and adjusting the thermostat.  In my defense, I knew the thermostat would switch to night mode in another 45 minutes and reduce the set point but I was still wasting energy.

Comparing the Filtrete to the nest the main features you are missing out on are:

<!-- more -->

* automatic occupancy detection
* humidity detection
* automatic schedule learning

Automatic scheduling is a big win for the average person but our schedule isn't static enough for this to be much benifit to us.  The location of our thermostat is about the best place for a thermostat, but not for occupancy detection so this feature isn't missed.  I'm a bit sad with the loss of humidity detection, the next model up Filtrete has it for $200 but it's not a deal breaker.

The real win for geeks with a WIFI thermostat isn't the iPhone or Android Apps, it's the ability to interface with it and do geeky things.  The Filtrete 3M-50 is a rebadged [Radio Thermostat Company of America CT30](http://www.radiothermostat.com/control.html).  Radio Thermostat has the API documentation hidden on their website in the [latest news section](http://www.radiothermostat.com/latestnews.html#advanced).  Scroll to the bottom of the page and click the 'I Accept' checkbox.  There is also a [3rd party wiki](http://central.isaroach.com/wiki/index.php/Main_Page) with API documentation and sample code.

I started with the [poller.pl](http://central.isaroach.com/wiki/index.php/Perl#Poller) script available on the wiki to go from nothing to something quickly.  There's a lack of error checking in it and the non CPANed Radio::Thermostat module available on that page but it gets you up and running quickly.

<img src="/images/2012/temperature-daily.png" />

After this, I wrote a simple script to tweet daily thermostat information.

{% include_code 2012/tweetstat.pl %}

Tweets look like:

* Yesterday averaged 59.5F outside and 67.9F inside with no heat or A/C used.
* Yesterday averaged 64.2F outside and 70.1F inside with heating runtime of 0:17.
* Yesterday averaged 58.9F outside and 69.0F inside with heating runtime of 0:31.

You can follow my house on Twitter as [@mikegrbs_house](https://twitter.com/#!/mikegrbs_house).
