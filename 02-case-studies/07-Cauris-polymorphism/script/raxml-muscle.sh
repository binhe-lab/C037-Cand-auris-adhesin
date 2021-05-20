#!/bin/bash
############################
# author: Bin He
# date: 2021-05-20
# title: RAxML tree search
# use: qsub raxml-muscle.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe orte 28
#$ -N raxml-muscle
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

# specify length of columns to be used for tree inference
length=400

# set input file
bioawk -c fastx -v l="$length" '{print ">"$name;print substr($seq, 1, l)}' ../output/gene-tree/cauris-four-strains-gene-tree_N500_muscle.faa >| ../output/gene-tree/cauris-four-strains-muscle-C${length}.faa
align=../output/gene-tree/cauris-four-strains-muscle-C${length}.faa

# estimate the tree
module load openmpi/2.1.2_gcc-8.3.0
mpirun /Users/bhe2/bin/raxmlHPC-MPI-AVX -f a -x 12345 -p 12345 -# 500 -m PROTGAMMAAUTO -s $align -n muscle-cauris-four-strains
