# Perl

A small collection of programs dealing with basic statistical analyses and manipulations of genomic files

Usage statements are affixed to each .pl

`stats.pl` takes a user-inputted set of numbers and returns statistics about the number set

`dnastats.pl` takes a user-inputted string of nucleotides and returns statistics about the sequence

`poisson.pl` calculates the probability of an event occurring given a Poisson distribution and user-inputted event and lambda values

`intron_comp.pl` takes a rearranged `.fasta` file and a k-mer length, parses it for introns to be sorted into "first (proximal)" and "distant", then calculates the log-odds ratios of k-mers occurring in both proximal and distant introns  

`genbank_codon.pl` takes a Genbank file of a bacteria, processes and parses the file for the DNA sequences, then counts the codon frequencies in the DNA sequences given coding coordinates, reverse-complementing the DNA sequence as necessary 
