---
title:
author:
date: 2020-06-29
---

# Results files
file(s) | description | source 
------- | ----------- | ------
species_tree.nwk | species tree | modified from Lindsey's species tree, removing _S. stipitis_
truncate_align.sh | SGE job script for aligning with clustalo | custom, HB
XP_028889033_homologs_edited_names.fasta | unaligned sequence files with edited names | LFS
XP_028889033_N500.faa | truncated first 500 aa from the above file | result from truncate-align.sh
XP_028889033_N500_clustalo.faa | aligned fasta using clustalo | result from truncate-align.sh
XP_028889033_N500_muscle.faa | aligned fasta using muscle | `muscle -in XP_028889033_N500.faa -out XP_028889033_N500_muscle.faa`
XP_*.reduced | same as above but identical sequences removed | generated automatically by RAxML
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree

# Phylogenetic analysis of the gene family Lindsey and Rachel worked on

