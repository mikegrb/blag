--- 
layout: post
title: Migrating Post Tags from Wordpress to Octopress
date: 2012-05-08 20:50:05 -04:00
tags: perl geek blog
comments: yes
---
I've migrated from Wordpress to Octopress and used the Jekyll [wordpress migrator](https://github.com/mojombo/jekyll/wiki/Blog-Migrations) to move my posts over.  Unfortunately, this doesn't preserve post tags.  The output looks like this:

``` yaml
--- 
layout: post
title: Devops w/ Perl @ Linode PPW Talk Slides
wordpress_id: 330
wordpress_url: http://michael.thegrebs.com/?p=330
date: 2011-10-27 14:46:31 -04:00
---
Earlier this month I gave a talk about...
```

Having the wordpress post id means extracting the post tags from the db should be quite easy.  First we define our desired output:

``` yaml
--- 
layout: post
title: Devops w/ Perl @ Linode PPW Talk Slides
wordpress_id: 330
wordpress_url: http://michael.thegrebs.com/?p=330
date: 2011-10-27 14:46:31 -04:00
tags: geek perl slides
---
Earlier this month I gave a talk about ...
```
The tags field really can appear anywhere in this YAML fragment but I chose to throw it at the end.  With 103 posts to loop over, run a query and insert a new line a short script makes sense.  The real win for our script though is using the [Tie::File](https://metacpan.org/module/Tie::File) module which presents each file as an array with an element for each line.

<!-- more -->

From there it's simply a matter of reverse engineering the Wordpress schema to come up with a query that will return a space delimited list of tags for a given post id.

``` sql
SELECT GROUP_CONCAT(t.`name` SEPARATOR " ") FROM `wp_term_relationships` r
INNER JOIN `wp_term_taxonomy` tax ON r.`term_taxonomy_id` = tax.`term_taxonomy_id`
INNER JOIN `wp_terms` t ON tax.`term_id` = t.`term_id`
WHERE r.`object_id` = ?
AND tax.`taxonomy` = "post_tag";
```

Throw that query in a script that iterates over the list of files and uses [Tie::File](https://metacpan.org/module/Tie::File) to add a line to the post and we get:

{% include_code 2012/word2octo-tags.pl %}
