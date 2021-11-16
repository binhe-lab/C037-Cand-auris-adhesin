#!/bin/bash
############################
# author: Bin He
# date: 2021-11-16
# title: RAxML tree search
# use: qsub raxml-clustalo-epa1.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe orte 28
#$ -N raxml-clustalo-epa1
#$ -cwd
#$ -j y
#$ -o ./log/
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

# set input file
in=../output/gene-tree/epa/cauris-four-strains-for-gene-tree-nog-epa_N500_clustalo.faa
# truncate the alignment by removing the first 45 columns and all columns after 400
trunc=${in/N500/C400}
bioawk -c fastx '{print ">"$name;print substr($seq, 45, 400)}' $in >| $trunc

# estimate the tree
module load stack/legacy
module load openmpi/2.1.2_gcc-8.3.0
mpirun /Users/bhe2/bin/raxmlHPC-MPI-AVX -f a -x 12345 -p 12345 -# 500 -m PROTGAMMAAUTO -s $trunc -n epa1_${JOB_ID}
