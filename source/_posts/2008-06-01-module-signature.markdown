--- 
layout: post
title: Module::Signature Rocks My Socks
wordpress_id: 116
wordpress_url: http://michael.thegrebs.com/?p=116
date: 2008-06-01 21:45:06 -04:00
comments: yes
tags: geek perl modules cpan
---
Just discovered the perl module <a href="http://search.cpan.org/~audreyt/Module-Signature/">Module::Signature</a> by å”é³³ (Audrey Tang) the other day.  It's pretty spiffy.

Implementing is easy (stolen from the docs):

MakeMaker:
<pre>    WriteMakefile(
        (MM->can('signature_target') ? (SIGN => 1) : ()),
        # ... original arguments ...
    );</pre>
Module::Build:
<pre>   Module::Build->new(
        (sign => 1),
        # ... original arguments ...
    )->create_build_script;</pre>

Don't forget to add <code>SIGNATURE</code> to your <code>MANIFEST</code> if needed.

Then when running <code>make dist</code> you will be prompted for the pass phrase for your gpg key.  For extra goodness, add <a href="http://search.cpan.org/src/AUDREYT/Module-Signature-0.55/t/0-signature.t">0-signature.t</a> to your tests.  It includes a single test that verifies the package cryptographically during <code>make test</code> if the <code>TEST_SIGNATURE</code> environment variable is set.

If you know waltman and haven't heard of this module, yell at him for not telling you about it, he's mentioned in the <code>AUTHORS</code> file for his stellar documentation patches.
