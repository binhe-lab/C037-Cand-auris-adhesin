#!/bin/bash
######BH
# author: Bin He
# date: 2020-02-24
# title: CATH genome scan to predict domains
# use: qsub cath-genome-scan.sh
#----------------------
# scheduler parameters
#$ -q BH
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -N cath-genome
#$ -cwd
#$ -o job-log/$JOB_NAME_$TASK_ID.out
#$ -e job-log/$JOB_NAME_$TASK_ID.err
#$ -t 1-5
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

files=(./genomescan/data/*.fasta)
i=$(($SGE_TASK_ID-1)) # $SGE_TASK_ID start from 1, while the array index start from zero
file=${files[$SGE_TASK_ID]}

if [ -f $file ]; then
	echo "Scanning $file"
	./genomescan/apps/cath-genomescan.pl -i $file -l ./genomescan/data/funfam-hmm3-v4_2_0.lib -o ./genomescan/results
else
	echo "$file doesn't exist"
	exit 1
fi

echo "finished"
