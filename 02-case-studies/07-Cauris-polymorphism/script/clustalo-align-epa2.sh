#!/bin/bash
############################
# author: Bin He
# date: 2021-11-16
# title: align-epa2
# use: qsub clustalo-align-epa2.sh
# modified: 
#   second step for epa
#----------------------
# scheduler parameters
#$ -q BH
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 5
#$ -N clustalo-align-epa2.sh
#$ -cwd
#$ -j y
#$ -o ./log
#----------------------
# -m ea will email the 
#    user when the job
#    ends or aborts
########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -u
set -o pipefail

mkdir -p log ../output/gene-tree
# run the truncate_align.sh to generate the alignment
in=../input/cauris-four-strains-for-gene-tree-epa.fasta
length=500
base=../output/gene-tree/cauris-four-strains-for-gene-tree-epa
trunc=${base}_N${length}.faa
align=${base}_N${length}_clustalo.faa

# truncate using bioawk
bioawk -c fastx -v l="$length" '{print ">"$name $comment;print substr($seq,1,l)}' $in >| $trunc

# align with clustalo
clustalo -i $trunc -o $align --iter=5 --force --outfmt=fasta -v -v
