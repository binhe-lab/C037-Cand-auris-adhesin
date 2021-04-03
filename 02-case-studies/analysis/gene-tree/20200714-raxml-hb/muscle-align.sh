#!/bin/bash
############################
# author: Bin He
# date: 2020-07-15
# title: align
# use: qsub muscle-align.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 10
#$ -N muscle-align.sh
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

# align with muscle
muscle -in XP_028889033_edited_N500.faa -out XP_028889033_edited_N500_muscle.faa
