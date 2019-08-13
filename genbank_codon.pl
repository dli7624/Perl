#!/usr/bin/perl
#genbank_codon.pl
use strict; use warnings;

die "usage: genbank_codon.pl <file>\n" unless @ARGV == 1;

my $genome = " ";
my $genbank = $ARGV[0];
my %codon_count = ();
my %codon_freq = ();
my $total_codons = 0;
my $codon;

open (my $in, '<', $genbank) or die "error reading $genbank";

while(<$in>) {
	if ($_ =~ /ORIGIN/) {
		while(<$in>) {
			$_ =~ s/[^yracgt]//g;
			$genome .= $_;
		}
	}
}

$genome = uc($genome);
#print length($genome), "\n"; #4686137 bp, #87401 y, #89425 r
close $genbank;
open ($in, '<', $genbank);

while(<$in>) {
	#CDS for forward strand
	if ($_ =~ /CDS/ && $_ =~ /[0-9]/ && $_ !~ /complement/) {

		my @seq_coordinates = $_ =~ /(\d+)/g;
		my $cds_length = $seq_coordinates[1] - $seq_coordinates[0];
		my $cds_forward = substr($genome, $seq_coordinates[0], $cds_length);

		for (my $i = 0; $i < length($cds_forward); $i += 3) {
			my $codon = substr($cds_forward, $i, 3);
			if (length($codon) == 3) {
				if (exists $codon_count{$codon}) {$codon_count{$codon}++}
				else 							 {$codon_count{$codon} = 1}
				$total_codons++;
			}
		} 
	}
	#CDS for reverse strands
	if ($_ =~ /CDS/ && $_ =~ /[0-9]/ && $_ =~ /complement/) {

		my @seq_coordinates = $_ =~ /(\d+)/g;
		my $cds_length = $seq_coordinates[1] - $seq_coordinates[0];	
		my $cds_rev_comp = substr($genome, $seq_coordinates[0], $cds_length);
			$cds_rev_comp = reverse($cds_rev_comp);
			$cds_rev_comp =~ tr/ATGCYR/TACGRY/;

		for (my $i = 0; $i < length($cds_rev_comp); $i += 3) {
			my $codon = substr($cds_rev_comp, $i, 3);
			if (length($codon) == 3) {
				if (exists $codon_count{$codon}) {$codon_count{$codon}++}
				else 							 {$codon_count{$codon} = 1}
				$total_codons++;
			}
		} 
	}
}

foreach $codon (sort keys %codon_count) {
	$codon_freq{$codon} = $codon_count{$codon}/$total_codons;
	printf "%s %.6f\n", $codon, $codon_freq{$codon};
}



