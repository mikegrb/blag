--- 
layout: post
title: DHS NOC MNC Poor Security Examples
date: 2012-05-29 20:32:10 -04:00
tags: geek dhs security government
comments: yes
---
<img src="/images/2012/US_Department_of_Homeland_Security_Seal.png" width="220" height="219" style="float: left;margin-right: 25px;margin-bottom:25px" />
The Media Monitoring Capability of the The Department of Homeland Security's National Operations Center is tasked with keeping existing situation summaries for both domestic and international events up to date with open source media information.  Their second mission is "to constantly monitor all available open source information with the goal of expeditiously alerting the NOC Watch Team and other key Department personnel of emergent situations".  This means monitoring both various online news sites as well as social networking.

Through a Freedom of Information Act request their [Analyst's Desktop Binder](/assets/2012/AnalystDesktopBinder-Redacted-.pdf) (4.4 MB PDF) was made publicly available.  This is essentially the employee manual for MMC analysts, describing how to preform their job.  There are quite a few very interesting tid bits in it such as the list of keywords and search terms used when searching social media sites.

Section 2.6 beginning on page 14 lists credible sources broken out into various tiers.  Local affiliates of the major networks are considered first tier sources and don't require any additional corroboration prior to release.  Meanwhile, all blogs "even if they are of a serious, political nature," are considered third tier sources and must be corroborated by a first tier source.

Also of interest were screen shots of various interfaces they use such as the Item Of Interest (IOI) report screen used to log an article and useful metadata.

<img src="/images/2012/create-ioi.png" width="789" height="511" />

The real problem with this document is the peak inside Homeland Security at how they do things.

Near the end, in section 8 'Usernames, Passwords & Contact Information,' we see that a common username and password are shared amongst analysts to log in to computers, shared drives, DHS email, and more.

<img src="/images/2012/sharing-is-caring.png" width="457" height="500" .>

I am interested in the twitter information in this section. [@DHSNOCMMC1](https://twitter.com/#!/DHSNOCMMC1) is a protected twitter account with no tweets and following 339 users.  I'd love to see the followers list but I'm sure it is filled with just a lot of boring traditional news organizations.

Jumping back a bit, to section 7, we find something even worse.  This section is called "HSIN __*REDACTED*__ Connection Instructions."  Here we see that __*REDACTED*__ is a system that is so vital to our security that even it's name must not be known.

<img src="/images/2012/sekrit.png" width="753" height="312" />

See?!?  It's obvious even to my seven year old that this is a system so vital to keep secret that even the name must be secret.

If one continues reading this section you come across this very surprising passage:

<img src="/images/2012/security-is-for-wuss.png" width="675" height="301" />

For those using screen readers due to blindness or those not trusting their eyes, this is the sentence in that image:

> After clicking on next, the following screen will appear and you must select “Accept for all sessions”

This is followed by an image of an invalid SSL certificate warning dialog.  All along experts have worried about teaching everyone's mother not to blindly accept invalid certificate warnings.  If Homeland Security is instructing their analysts to blindly accept invalid SSL certificate warnings then not only have we lost the war, the enemy is dancing on our grave as the baby jesus cries dark tears in the corner.
