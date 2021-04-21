#!/bin/bash
############################
# author: Bin He
# date: 2021-04-19
# title: align-nog
# use: qsub clustalo-align-nog.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 5
#$ -N clustalo-align-nog.sh
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
in=../input/cauris-five-strains-for-gene-tree-no-outgroup.fasta
length=500
base=../output/gene-tree/cauris-five-strains-gene-tree-nog
trunc=${base}_N${length}.faa
align=${base}_N${length}_clustalo.faa

# truncate using bioawk
bioawk -c fastx -v l="$length" '{print ">"$name $comment;print substr($seq,1,l)}' $in >| $trunc

# align with clustalo
clustalo -i $trunc -o $align --iter=5 --force --outfmt=fasta -v -v

# refine the alignment with muscle
muscle -in ../output/gene-tree/cauris-five-strains-gene-tree-nog_N500_clustalo.faa -out ../output/gene-tree/cauris-five-strains-gene-tree-nog_N500_muscle_refined.faa -refine
