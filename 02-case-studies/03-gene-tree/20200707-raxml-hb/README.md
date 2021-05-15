---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2020-07-06
---
# Goal
A repeat of the 2020-07-06 analysis (see sister folder). After inspecting the alignment file with `alv -kw 100 XP_028889033_N500_clustalo.faa | less -R`, I noticed that after the first 500 columns, the sequences appear to be highly repetitive and the alignment quality dropped a lot. I wonder what would happen if we build trees only using the first 500 columns. To do so, I used the following command to print just the first 500 columns of both the muscle and clustalo alignments

```bash
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 500)}' XP_028889033_edited_N500_clustalo.faa > XP_028889033_clustalo_C500.faa
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 500)}' XP_028889033_edited_N500_muscle.faa > XP_028889033_muscle_C500.faa
```

# Results files
file(s) | description | source 
------- | ----------- | ------
XP_028889033_homologs_combine_edited.fasta | same as above but with the first 900 aa of XP_025344407.1 deleted (see notes below) | HB
XP_028889033_edited_N500.faa | truncated first 500 aa from the above file | result from truncate-align.sh
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

