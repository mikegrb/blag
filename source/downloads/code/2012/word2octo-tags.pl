#!/usr/bin/perl 

use 5.010;
use strict;
use warnings;

use DBI;
use Tie::File;

my $path_to_posts = 'source/_posts';

my $dbh = DBI->connect('DBI:mysql:db_name:db_host','db_user','db_pass');

my $get_tags = $dbh->prepare(q{
    SELECT GROUP_CONCAT(t.`name` SEPARATOR " ") FROM `wp_term_relationships` r
    INNER JOIN `wp_term_taxonomy` tax ON r.`term_taxonomy_id` = tax.`term_taxonomy_id`
    INNER JOIN `wp_terms` t ON tax.`term_id` = t.`term_id`
    WHERE r.`object_id` = ?
    AND tax.`taxonomy` = "post_tag";
    });


for my $file (glob "$path_to_posts/*.markdown") {
    say $file;
    add_tags_to_file($file);
}

sub add_tags_to_file {
    my $filename = shift;
    tie my @file, 'Tie::File', $filename or die "No tie: $!";
    my $tags;
    while (my ($rec, $data) = each @file) {
        if ($data =~ m/^wordpress_id: (\d+)$/) {
            $tags = get_tag($1);
        }
        if( $data =~ /^date:/) {
            splice @file, $rec + 1, 0, $tags if $tags;
            return;
        }

    }
}

sub get_tag {
    my $post = shift;
    $get_tags->execute($post);
    my ($tags) = $get_tags->fetchrow_array();
    return "tags: " . $tags if $tags;
}

