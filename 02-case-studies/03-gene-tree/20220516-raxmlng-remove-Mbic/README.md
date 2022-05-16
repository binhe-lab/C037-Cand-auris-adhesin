---
title: Gene tree analysis with expanded blast homologs
author: Bin He
date: 2022-05-16
---

# Goal
**Update**

This is a rerun of the 20220512 analysis, with one major change: sequences from _Metschnikowia bicuspidata_ were dropped -- 27/29 proteins from the species are shorter than 500 a.a. 10 of them were labeled as "incomplete" in the refseq database. Nine of those ten incomplete proteins also had short PF11765 match by hmmscan or cdsearch (shorter than 300 a.a.).

**Original notes**

There are three changes in this version. First, the homolog list has been expanded to include additional species and homologs identified in newer assemblies. See `02-blast/analysis/expanded-blast` for details. Second, we will experiment with alignment trimming software and test its impact on the resulting tree. In particular, we will try [BMGE](http://gensoft.pasteur.fr/docs/BMGE/1.12/BMGE_doc.pdf) and [ClipKIT](https://github.com/JLSteenwyk/ClipKIT). The former calculates a score that is closely related to entropy, and weight it by a similarity matrix. The idea is to come up with a measure of how likely it is for evolution to generate the observed character states in the column (of the alignment). Some cutoff is used to remove "unlikely" columns. The latter is from the Rokas lab. Instead of removing poorly aligned columns, the software tries to retain columns based on a measure related to how informative it is for parsimony inference. I'll try both methods.

# Notes
## 2022-05-14 raxml-ng
I switched completely to `raxml-ng` and figured out how to use the MPI hybrid mode for parallelization. See `script/README.md`

# Results files
file(s) | description | source 
------- | ----------- | ------
