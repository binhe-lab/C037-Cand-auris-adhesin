#!/bin/bash
###########################
# author: Bin He
# date: 2022-06-30
# title: split alignment
# use: sh split-align.sh
###########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -euo pipefail

# input file name
in=../input/homologs/B8441-Hil1-8-PF11765-aligned.fna
# sequence length
l=$(bioawk -c fastx 'NR==1{print length($seq)}' $in)
# breakpoint
bp1=699
# output file names
base=../input/homologs/B8441-Hil1-8-PF11765
first=${base}-1-${bp1}.fna
second=${base}-$(($bp1+1))-${l}.fna

# split using bioawk
bioawk -c fastx -v l="$bp1" '{print ">"$name $comment;print substr($seq,1,l)}' $in >| $first
bioawk -c fastx -v l="$(($bp1+1))" -v L="$l" '{print ">"$name $comment;print substr($seq,l,L)}' $in >| $second

