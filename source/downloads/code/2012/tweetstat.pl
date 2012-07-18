#!/usr/bin/perl 

use 5.010;
use strict;
use warnings;

use RRDs;
use DateTime;
use Net::Twitter;
use Mojo::UserAgent;
use List::Util 'sum';

my $runtime  = get_runtime_string();
my $averages = get_averages_string();

die unless $runtime && $averages;

my $tweet = "Yesterday $averages with $runtime.";
say $tweet;

my $consumer_key    = '';
my $consumer_secret = '';
my $token           = '';
my $token_secret    = '';

my $thermostat_url  = 'http://10.8.8.98/tstat/datalog';
my $rrd_path        = '/home/michael/srv/therm/poller/data/temperature.rrd';

my $nt = Net::Twitter->new(
    traits   => [qw/OAuth API::REST/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $token,
    access_token_secret => $token_secret,
);

$nt->update($tweet);


sub get_runtime_string {
    my $ua = Mojo::UserAgent->new;
    my $res = $ua->get($thermostat_url)->res;

    die "Didn't get runtimes for yesterday" unless $res;

    my $data = $res->json;
    return build_runtime_string('heat', $data->{ yesterday } )
        || build_runtime_string('cool', $data->{ yesterday } )
        || "no heat or A/C used";
}

sub build_runtime_string {
    my ($mode, $data)  = @_;
    my $times = $data->{ $mode . '_runtime' };
    return unless $times->{ hour } || $times->{ minute };
    return sprintf '%sing runtime of %i:%02i',
        $mode, $times->{ hour }, $times->{ minute };
}

sub get_averages_string {
    my $yesterday = DateTime->now()->subtract( days => 1);

    my $start_of_day = DateTime->new(
        year    => $yesterday->year,
        month   => $yesterday->month,
        day     => $yesterday->day,
        hour   => 0,
        minute => 0,
        second => 0,
        time_zone => 'America/New_York'
    );

    my $end_of_day = $start_of_day->clone->add( hours => 24 );

    my ($start,$step,$names,$data) = RRDs::fetch (
        $rrd_path,
        'AVERAGE',
        '-s ' . $start_of_day->epoch,
        '-e ' . $end_of_day->epoch
    );

    if (my $error = RRDs::error) {
        die "Error reading RRD data: $error";
    }

    my (@ext_temp, @int_temp);
    for my $row (@$data) {
        next unless grep { $_ } @$row;
        my ($outside, $inside) = @$row[2, 5];
        push @ext_temp, $outside;
        push @int_temp, $inside;
    }

   return  sprintf "averaged %.1fF outside and %.1fF inside",
        average( \@ext_temp), average(\@int_temp);
}

sub average {
    my $list = shift;
    return sum(@$list) / @$list;
}
