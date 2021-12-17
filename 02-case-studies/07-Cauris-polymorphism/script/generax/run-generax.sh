#!/bin/bash
# title: run GeneRax to "correct" the gene tree by reconciling it with the species tree using ML
# author: Bin He
# date: 2021-12-06

# all input files for the analysis is included in this folder to keep things organized
# this script file is meant to be run by copy-n-pasting the individual commands to the command line and run individually

# 2021-12-06 run 1 was a test with radius = 3
generax --families families.txt --species-tree cauris-four-strains-outgroup-tree.nwk --rec-model UndatedDL --per-family-rates --prefix ../../output/gene-tree/generax/20211206-run1 --max-spr-radius 3

# 2021-12-06 run 2 uses the recommended radius = 5, and used the parallel version, although that didn't speed things up by very much (run 1 took only 3 min after all)
mpiexec -np 5 generax --families families.txt --species-tree cauris-four-strains-outgroup-tree.nwk --rec-model UndatedDL --per-family-rates --prefix ../../output/gene-tree/generax/20211206-run2 --max-spr-radius 5
