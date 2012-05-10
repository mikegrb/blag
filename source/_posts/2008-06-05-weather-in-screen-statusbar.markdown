--- 
layout: post
title: Weather in Screen Statusbar
wordpress_id: 117
wordpress_url: http://michael.thegrebs.com/?p=117
date: 2008-06-05 23:06:14 -04:00
comments: yes
tags: geek screen shell
---
<img src="http://michael.thegrebs.com/wp-content/uploads/2008/06/screen-weather.png" alt="" title="Weather in Screen" width="279" height="49" class="alignright size-full wp-image-120" />

Caspar Clemens Mierau <a href="http://www.screenage.de/blog/2008/06/04/my-package-of-the-day-weather-util-weather-report-and-forecast-for-the-console/">recently wrote</a> about a nifty Debian package named <tt>weather-util</tt> and his method for embedding the current temperature into the screen status bar.  Quite nifty.  I did the same with one small exception, including the predicted probability of precipitation if it exists.

My one liner that runs from cron (split to multiple lines for readability):

```
    weather -iKACY -f | head -n 9  | \
         awk '/Temperature/ { print $2 "F" } 
              /Relative/ { print $3 } 
              /precipitation/ { sub (/ chance of.+$/, ""); print "POP " $NF }' | \
         xargs echo > /home/michael/.weather
```

More details on the full implementation in the original post over at <a href="http://www.screenage.de/blog/2008/06/04/my-package-of-the-day-weather-util-weather-report-and-forecast-for-the-console/">Caspar Clemens Mierau's blog</a>.  And yes, I stole his loadavg stuff too ;)

<strong>UPDATE:</strong>

Silly me, upon further investigation, two things to note.  First, the -i option applies only to current conditions and not to the forecast.  In my case I actually want <tt>weather -f ACY</tt> and <tt>/etc/weatherrc</tt> takes care of the rest.  Secondly, the field number for the precipitation percentage changes, oops.  I've correctly accounted for this in the updated awk script above.

After making these changes I decided the awk script was getting a bit long for a single line so I went all out creating <tt>~/bin/weather.awk</tt>:

```
#!/usr/bin/awk -f

/Temperature/       { temp = $2 }
/Relative Humidity/ { rh = $3   }
/precipitation/     { sub (/ chance of.+$/, "");
                      precip = $NF;
                      exit
                    }

END { print temp "F " rh " POP " precip }
```

My crontab entry now looks like:

    */5 * * * *     weather -f ACY | /home/michael/bin/weather.awk > /home/michael/.weather

Much simpler.
