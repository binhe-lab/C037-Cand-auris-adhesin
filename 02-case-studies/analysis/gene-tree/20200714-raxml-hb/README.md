---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2020-07-14
---
# Goal
A repeat of the 2020-07-07 analysis (see sister folder). After attempting to write the species tree for reconciling the gene tree, I found that the new species I introduced in this round of blast, _D. rugosa_, could introduce polytomy to the species tree due to conflicting reports on its phylogenetic position (see `../README.md` notes on writing new species tree). For this reason I decide to remove the _D. rugosa_ sequences, realign and repeat the gene tree reconstruction.

For removing the _D. rugosa_ sequences, I simply edited `XP_028889033_edited_N500.faa` using vim, with `vim "Drugosa" % | cw` to find all the relevant sequences and manually delete them.

To extract the first 500 columns in the alignment for tree reconstruction, I used the following commands.

```bash
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 530)}' XP_028889033_edited_N500_clustalo.faa > XP_028889033_clustalo_C530.faa
$ bioawk -c fastx '{print ">"$name;print substr($seq, 1, 530)}' XP_028889033_edited_N500_muscle_refined.faa > XP_028889033_muscle_refined_C530.faa
```

To align the sequences, I first did the ClustalO alignment with 50 iterations, which took 3 hours on 10 slots on ARGON. Instead of running Muscle on the unaligned sequences, I decided to use the `muscle -in <Aligned> -out <Refined> -refine` function. This took no time to complete, but upon inspecting the output, there seems to be very minimal changes. Nonetheless, I decided to run RAxML on both, this time only on the first 530 columns of both alignments.

# Results files
file(s) | description | source 
------- | ----------- | ------
XP_028889033_edited_N500.faa | based on the same file in `../20200706-raxml-hb` but with _D. rugosa_ sequences removed | manually edited
XP_028889033_edited_N500_clustalo.faa | aligned fasta using clustalo | result from clustalo-align.sh, took 3 hrs on 10 cores
XP_028889033_clustalo_C500.faa | Extracted first 500 columns from the above file | See above for command
XP_028889033_edited_N500_muscle_refined.faa | refined the above alignment using muscle | `muscle -in XP_028889033_edited_N500.faa -out XP_028889033_edited_N500_muscle_refined.faa -refine`
XP_028889033_muscle_refined_C530.faa | Extracted first 500 columns from the above file | See above for command
clustalo-align.sh | SGE job script for running aligner | custom, HB
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree

