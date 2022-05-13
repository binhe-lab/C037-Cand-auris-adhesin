#!/bin/bash
############################
# author: Bin He
# date: 2022-05-13
# title: RAxML-ng tree search
# use: qsub raxmlng-clustalo.sh
#----------------------
# scheduler parameters
#$ -q BH,BIO-INSTR
#$ -M bhe2@uiowa.edu
#$ -m ea
#$ -pe orte 28
#$ -N raxml-clustalo
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
in=../input/20220512-expanded-blast-combined-homologs-PF11765-longname.faa
base=../output/raxmlng/clustalo/expanded-blast-PF11765
align=${base}_clustalo.faa
bmge=${base}_clustalo_bmge.faa
clip=${base}_clustalo_clipkit.faa

# align with clustalo
clustalo -i $in -o $align --iter=5 --force --outfmt=fasta -v

# trim the alignment with BMGE or ClipKIT
bmge -i $align -t AA -g 0.5 -of $bmge
clipkit $align -o $clip

# estimate the tree
raxml-ng --all --msa $bmge --model LG+G --seed 123 --threads 6 --bs-trees autoMRE --prefix ${bmge%.*}
raxml-ng --all --msa $clip --model LG+G --seed 123 --threads 6 --bs-trees autoMRE --prefix ${clip%.*}
#module load openmpi/2.1.2_gcc-8.3.0
#mpirun /Users/bhe2/bin/raxmlHPC-MPI-AVX -f a -x 12345 -p 12345 -# 500 -m PROTGAMMAAUTO -s $align -n clustalo_${JOB_ID}
