#!/bin/bash
############################
# author: Bin He
# date: 2021-03-01
# title: RAxML tree search
# use: qsub raxml-clustalo.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe orte 56
#$ -N raxml
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

base=expanded-blast-PF11765_clustalo_clipkit
align=../output/align/${base}.faa
outdir=/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/03-gene-tree/20220512-raxmlng-expanded/output/raxml

# estimate the tree
# module load stack/2021.1
module load openmpi/4.0.5_gcc-9.3.0
mpirun /Users/bhe2/bin/raxmlHPC-MPI-AVX -f a -x 12345 -p 12345 -# 500 -m PROTGAMMAAUTO -s $align -w $outdir -n $base_${JOB_ID}
