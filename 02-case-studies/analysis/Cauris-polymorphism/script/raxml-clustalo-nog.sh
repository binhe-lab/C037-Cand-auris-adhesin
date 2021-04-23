#!/bin/bash
############################
# author: Bin He
# date: 2021-04-19
# title: RAxML tree search
# use: qsub raxml-clustalo-nog.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe orte 28
#$ -N raxml-clustalo-nog
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
bioawk -c fastx -v l="$length" '{print ">"$name;print substr($seq, 1, l)}' ../output/gene-tree/cauris-five-strains-gene-tree-nog_N500_clustalo.faa > ../output/gene-tree/cauris-five-strains-nog-clustalo-C${length}.faa
align=../output/gene-tree/cauris-five-strains-nog-clustalo-C${length}.faa

# estimate the tree
module load openmpi/2.1.2_gcc-8.3.0
mpirun /Users/bhe2/bin/raxmlHPC-MPI-AVX -f a -x 12345 -p 12345 -# 500 -m PROTGAMMAAUTO -s $align -n nog-clustalo_${JOB_ID}
