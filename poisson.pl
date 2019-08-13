#!/usr/bin/perl
#poisson.pl
use strict; use warnings;

use constant EULER => 2.71828;
use constant PI => 3.14159265358979;

my $factorial;
my $prob;
my ($event, $lambda) = @ARGV;

#check for event and lambda values 
die "usage: poisson.pl\nNeed two input values: <# of events> <lambda>\n" 
	unless @ARGV == 2;

#check if both values are ints	
if ($event !~ /^\d+$/ && $lambda !~ /^\d+$/) {
	die "Both values invalid\n";
}
#check if event value is integer		
if ($event !~ /^\d+$/ or (int($event) != ($event))) {
	die "Invalid event value\n";
}
#check if lambda value is integer > 0
if ($lambda !~ /^\d+$/ or int($lambda) != ($lambda) or $lambda == 0) {
	die "Invalid lambda value\n";
}

if ($event == 0) {
	$factorial = 1; 
}

else { 
	$factorial = 
	(EULER ** ((0.5 * log(2*PI))
	+ ($event + 0.5) * log($event)
	- $event + 1 / (12 * $event)
	- 1 / (360 * ($event ** 3))));
}

$prob = ((EULER ** (-1*$lambda)) * (($lambda**$event) / ($factorial)));

printf("%.3g\n", $prob);
