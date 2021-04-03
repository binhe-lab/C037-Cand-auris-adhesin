#!/bin/bash
############################
# author: Bin He
# date: 2020-07-15
# title: align
# use: qsub clustalo-align.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 30
#$ -N clustalo-align.sh
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
in=XP_028889033_edited_N500.faa
base=XP_028889033_edited_N500
align=${base}_clustalo.faa

# align with clustalo
clustalo -i $in -o $align --iter=5 --force --outfmt=fasta -v -v
