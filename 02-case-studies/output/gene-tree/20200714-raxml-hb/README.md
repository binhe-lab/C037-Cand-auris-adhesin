---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2020-07-14
---
# Goal
A repeat of the 2020-07-07 analysis (see sister folder). After attempting to write the species tree for reconciling the gene tree, I found that the new species I introduced in this round of blast, _D. rugosa_, could introduce polytomy to the species tree due to conflicting reports on its phylogenetic position (see `../README.md` notes on writing new species tree). For this reason I decide to remove the _D. rugosa_ sequences, realign and repeat the gene tree reconstruction.

```bash
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 500)}' XP_028889033_edited_N500_clustalo.faa > XP_028889033_clustalo_C500.faa
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 500)}' XP_028889033_edited_N500_clustalo.faa > XP_028889033_muscle_C500.faa
```

# Results files
file(s) | description | source 
------- | ----------- | ------
XP_028889033_edited_N500.faa | based on the same file in `../20200706-raxml-hb` but with _D. rugosa_ sequences removed | manually edited
XP_028889033_edited_N500_clustalo.faa | aligned fasta using clustalo | result from truncate-align.sh
XP_028889033_clustalo_C500.faa | Extracted first 500 columns from the above file | See above for command
XP_028889033_edited_N500_muscle.faa | aligned fasta using muscle | `muscle -in XP_028889033_edited_N500.faa -out XP_028889033_edited_N500_muscle.faa`
XP_028889033_muscle_N500.faa | Extracted first 500 columns from the above file | See above for command
XP_*.reduced | same as above but identical sequences removed | generated automatically by RAxML
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree

