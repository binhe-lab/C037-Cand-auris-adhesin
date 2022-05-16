#!/bin/bash
# title: run GeneRax to "correct" the gene tree by reconciling it with the species tree using ML
# author: Bin He
# date: 2021-12-07

# all input files for the analysis is included in this folder to keep things organized
# this script file is meant to be run by copy-n-pasting the individual commands to the command line and run individually

# 2021-12-07 uses the recommended radius = 5, and used the parallel version
mpiexec -np 2 generax --families families-clustalo.txt --species-tree generax/species-tree.nwk --rec-model UndatedDL --per-family-rates --prefix ../output/generax --max-spr-radius 5
