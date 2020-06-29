#!/bin/bash
############################
# author: Bin He
# date: 2020-06-27
# title: RAxML tree search
# use: qsub raxml.sh
#----------------------
# scheduler parameters
#$ -q BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 8
#$ -N raxml
#$ -cwd
#$ -o job-log/$JOB_NAME_$TASK_ID.out
#$ -e job-log/$JOB_NAME_$TASK_ID.err
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

/Users/bhe2/bin/raxmlHPC-PTHREADS-AVX -x 12345 -p 12345 -# autoMRE -m PROTGAMMAAUTO -s OG5_132045_N500.faa -n TH8 -T 8
