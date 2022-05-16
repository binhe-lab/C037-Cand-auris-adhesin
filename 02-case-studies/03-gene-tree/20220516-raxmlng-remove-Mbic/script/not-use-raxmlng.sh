#!/bin/bash
############################
# author: Bin He
# date: 2022-05-13
# title: RAxML-ng tree search
# use: qsub raxmlng.sh
#----------------------
# scheduler parameters
#$ -q BH
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 10
#$ -N raxmlng
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

# set input and intermediate file names
#in=test.faa
#base=test
base=../output/align/expanded-blast-PF11765
clustalo=${base}_clustalo_clipkit.faa
hmmalign=${base}_hmmalign_clipkit.faa

# estimate the tree
raxml-ng --all --msa $clustalo --model LG+G --seed 123 --threads 7 --bs-trees autoMRE --prefix ${clustalo%.*}
#raxml-ng --all --msa $clip --model LG+G --seed 123 --threads 6 --bs-trees autoMRE --prefix ${clip%.*}
