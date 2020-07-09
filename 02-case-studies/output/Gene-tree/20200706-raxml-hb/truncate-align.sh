#!/bin/bash
############################
# author: Bin He
# date: 2020-07-06
# title: align
# use: qsub truncate-align.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 10
#$ -N truncate-align.sh
#$ -cwd
#$ -o job-log/$JOB_NAME_$JOB_ID.out
#$ -e job-log/$JOB_NAME_$JOB_ID.err
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

# run the truncate_align.sh to generate the alignment
in=XP_028889033_homologs_combine_edited.fasta
length=500
base=XP_028889033_edited
trunc=${base}_N${length}.faa
align=${base}_N${length}_clustalo.faa

# truncate using bioawk
bioawk -c fastx -v l="$length" '{print ">"$name $comment;print substr($seq,1,l)}' $in >| $trunc

# align with clustalo
clustalo -i $trunc -o $align --iter=50 --force --outfmt=fasta
