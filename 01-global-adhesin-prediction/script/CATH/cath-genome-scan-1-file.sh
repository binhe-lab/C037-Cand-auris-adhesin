#!/bin/bash
######BH
# author: Bin He
# date: 2020-07-16
# title: CATH genome scan to predict domains
# use: qsub cath-genome-scan-1-file.sh
#----------------------
# scheduler parameters
#$ -q BH
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -N cath-genome
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

file=genomescan/data/all_predicted_adhesins_w_other.fasta

if [ -f $file ]; then
	echo "Scanning $file"
	./genomescan/apps/cath-genomescan.pl -i $file -l ./genomescan/data/funfam-hmm3-v4_2_0.lib -o ./genomescan/results
else
	echo "$file doesn't exist"
	exit 1
fi

echo "finished"
