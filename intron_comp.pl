#!/usr/bin/perl
#intron_comp.pl
use strict; use warnings;

die "usage: intron_comp.pl <file> <kmer length>\n" unless @ARGV == 2;
my ($file, $kmer) = @ARGV;
my $codon; 
my $next_line;
my (%count1, %count2) = ();
my (%freq1, %freq2) = ();
my $kmer_count1 = 0; 
my $kmer_count2 = 0;
my $odds_ratio, my $lod, my $lod2;

open(my $in, $file) or die "error reading $file";
while(<$in>) {

	if ($_ =~ /i1/) {
		$next_line = <$in>;
		for (my $i = 0; $i < length($next_line); $i += $kmer) {
			my $codon = substr($next_line, $i, $kmer);
			if ($codon !~ /\s/) {
				if (exists $count1{$codon}) {$count1{$codon}++}
				else						{$count1{$codon} = 1}
				$kmer_count1++;
			}
		}
	}		

	if (($_ !~ /i1/) && ($_ =~ />/)) {
		$next_line = <$in>; 
		for (my $i = 0; $i <length($next_line); $i += $kmer) {
			my $codon = substr($next_line, $i, $kmer);
			if ($codon !~ /\s/) {
				if (exists $count2{$codon}) {$count2{$codon}++}
				else						{$count2{$codon} = 1}
				$kmer_count2++;
			}		
		}
	}	
}	
close $in;

foreach $codon (sort keys %count1) {
	$freq1{$codon} = $count1{$codon}/$kmer_count1;
}
foreach $codon (sort keys %count2) {
	$freq2{$codon} = $count2{$codon}/$kmer_count2;
}

foreach my $codon (sort keys %count1) {
	my $odds_ratio = $freq1{$codon} / $freq2{$codon};
	my $lod = log($odds_ratio);
	my $lod2 = $lod / log(2);
	printf "%s %.3f\n", $codon, $lod2;
}
