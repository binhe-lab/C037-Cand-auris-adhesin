#!/bin/bash
############################
# author: Bin He
# date: 2022-05-16
# title: align sequences using clustalo or hmmalign
# use: qsub align.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 10
#$ -N align
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
in=../input/20220516-expanded-blast-remove-Mbic-PF11765-longname.faa
base=../output/align/expanded-blast-PF11765-noMbic
clustalo=${base}_clustalo.faa
hmmalign=${base}_hmmalign.faa

echo "Align with ClustalO"
# align with clustalo
clustalo -i $in -o $clustalo --iter=5 --threads=10 --force --outfmt=fasta -v

echo "Align with hmmalign"
# align with hmmalign
hmmalign -o $hmmalign --outformat phylip ../../../02-blast/data/HMM-profile/Hyphal_reg_CWP.hmm $in

echo "Trimming alignment uisng ClipKIT"
# trim the alignment with ClipKIT
clipkit $clustalo -o ${clustalo%.*}_clipkit.phy -of fasta
clipkit $hmmalign -o ${hmmalign%.*}_clipkit.phy -of fasta
