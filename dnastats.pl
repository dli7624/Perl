#!/usr/bin/perl
#dnastats.pl
use strict; use warnings;

die "usage: dnastats.pl <dna sequence>\n" unless @ARGV == 1;
my ($seq) = @ARGV;


die "non-DNA characters detected\n" if ($seq !~ m/^[acgt]+$/i);

#transliterate for seq counter
$seq =~ tr/a-z/A-Z/;

#length of seq
my ($seq_length) = length($seq);
print ("\nSequence length in base(s): ", $seq_length, "\n\n");

#total number of each ACGT
my ($a_count) = ($seq =~ tr/A/A/); 
my ($c_count) = ($seq =~ tr/C/C/);
my ($g_count) = ($seq =~ tr/G/G/);
my ($t_count) = ($seq =~ tr/T/T/);
print ("Base Frequencies\n----------------\nAdenine:  ", $a_count, "\n");
print ("Cytosine: ", $c_count, "\n");
print ("Guanine:  ", $g_count, "\n");
print ("Thymine:  ", $t_count, "\n\n");

#fraction of each ACGT
print ("%A:  ", $a_count / $seq_length*100, "%\n");
print ("%C:  ", $c_count / $seq_length*100, "%\n");
print ("%G:  ", $g_count / $seq_length*100, "%\n");
print ("%T:  ", $t_count / $seq_length*100, "%\n");

#GC content
print ("%GC: ", (($c_count + $g_count) / $seq_length*100), "%\n");
