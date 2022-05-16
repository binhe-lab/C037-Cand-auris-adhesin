#!/bin/bash
############################
# title: run GeneRax to "correct" the gene tree by reconciling it with the species tree using ML
# author: Bin He
# date: 2021-12-07
# use: qsub generax-clustalo.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe smp 56
#$ -N generax-clustalo
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

# 2021-12-07 uses the recommended radius = 5, and used the parallel version
mpiexec -np 56 generax --families families-clustalo.txt --species-tree generax/species-tree.nwk --rec-model UndatedDL --per-family-rates --prefix ../output/generax --max-spr-radius 5
