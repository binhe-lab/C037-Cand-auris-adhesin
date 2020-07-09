---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2020-07-06
---
# Goal
Repeat the gene tree analysis with the newly assembled homologs consisting of more species and combining FungiDB and Refseq protein database hits.

# Results files
file(s) | description | source 
------- | ----------- | ------
species_tree.nwk | species tree | modified from Lindsey's species tree, removing _S. stipitis_
truncate_align.sh | SGE job script for aligning with clustalo | custom, HB
XP_028889033_homologs_combine.fasta | combined blast hits from fungidb and refseq_protein | HB
XP_028889033_homologs_combine_edited.fasta | same as above but with the first 900 aa of XP_025344407.1 deleted (see notes below) | HB
XP_028889033_edited_N500.faa | truncated first 500 aa from the above file | result from truncate-align.sh
XP_028889033_edited_N500_clustalo.faa | aligned fasta using clustalo | result from truncate-align.sh
XP_028889033_edited_N500_muscle.faa | aligned fasta using muscle | `muscle -in XP_028889033_edited_N500.faa -out XP_028889033_edited_N500_muscle.faa`
XP_*.reduced | same as above but identical sequences removed | generated automatically by RAxML
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree

# Notes
## 2020-07-06 alignment
- After constructing the clustalo alignment, I found one of the sequences jump out as being poorly aligned (XP_025344407.1 from _C. haemuloni_). However, upon checking its blast e-value, I found it aligne with the querry very well, with 5e-149 e-value, 56% query coverage and 77.5% identity. I then discovered the issue: this sequence appears to be the single outlier in that the match in the subject sequence is not in the N-terminus, but in the middle of this unusally long protein (~4400 aa, with most of the other sequences between 328-3300, with median of 940.5 aa and 90% percentile at 1912.5 aa). Since my truncate and align program first truncates each protein at the 500 aa mark, it is not surprising that this sequence would fail to align. To correct this problem, I deleted the first 900 aa of this sequence and saved the new file as `XP_028889033_homologs_combine_edited.fasta` and reran the `truncate-align.sh` program with this file as input.
