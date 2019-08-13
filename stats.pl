#!/usr/bin/perl
#stats.pl
#use POSIX;
use strict; use warnings;

die "usage: stats.pl <number1> <number2> <etc>\n" unless @ARGV > 1;

print("Count: ", scalar(@ARGV), "\n");

#sorting numbers
my @sorted = sort {$a <=> $b} @ARGV;

#print "numeric: @sorted\n"; 
print "Min = ", $sorted[0], "\n";
print "Max = ", $sorted[-1], "\n";

my $sum = 0;

foreach (@ARGV) {
	$sum += $_;
}
print "Sum = $sum\n";

my $mean = ($sum / @ARGV);

printf ("Mean = %.2f\n", $mean);

#median based on odd/even # of entries
my $median;
my $midpoint = (@ARGV/2);

if (@ARGV % 2) {
	$median = $sorted[$midpoint];
}
elsif (@ARGV % 2 == 0) {
	$median = (($sorted[$midpoint] + $sorted[$midpoint-1]) / 2);
}
printf ("Median = %.2f\n", $median);

#var and stdev
my $varsum = 0;

foreach (@ARGV) {
	$varsum = ($_ - $mean)**2;
}

my $variance = ($varsum / @ARGV);
my $population_var = ($varsum / (@ARGV - 1));
my $stdev = (sqrt($varsum));

printf ("Variance = %.3f\n", $variance);
printf ("Population Var. = %.3f\n", $population_var);
printf ("Stdev = %.3f\n", $stdev);