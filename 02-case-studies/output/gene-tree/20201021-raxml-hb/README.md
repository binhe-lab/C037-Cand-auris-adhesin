---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2020-07-14
---
# Goal
A repeat of the 2020-07-23 analysis (see sister folder) on an updated version of the homologs sequence.

To align the sequences, I first did the ClustalO alignment with 50 iterations, which took only a few minutes on 30 slots on ARGON. Instead of running Muscle on the unaligned sequences, I decided to use the `muscle -in <Aligned> -out <Refined> -refine` function. This took no time to complete, but upon inspecting the output, there seems to be very minimal changes. Nonetheless, I decided to run RAxML on both, this time only on the first 480 columns of both alignments.

To extract the first 480 columns in the alignment for tree reconstruction, I used the following commands.

```bash
bioawk -c fastx '{print ">"$name;print substr($seq, 1, 480)}' XP_028889033_homologs_N500_clustalo.faa > XP_028889033_clustalo_C480.faa
bioawk -c fastx '{print ">"$name;print substr($seq, 1, 480)}' XP_028889033_homologs_N500_muscle_refined.faa > XP_028889033_muscle_refined_C480.faa
```


# Results files
file(s) | description | source 
------- | ----------- | ------
XP_028889033_homologs_N500.faa | homologs sequences | copied from `../blast/`
XP_028889033_homologs_N500_clustalo.faa | aligned fasta using clustalo | result from clustalo-align.sh
XP_028889033_clustalo_C480.faa | Extracted first 480 columns from the above file | See above for command
XP_028889033_homologs_N500_muscle_refined.faa | refined the above alignment using muscle | `muscle -in XP_028889033_homologs_N500.faa -out XP_028889033_homologs_N500_muscle_refined.faa -refine`
XP_028889033_muscle_refined_C480.faa | Extracted first 480 columns from the above file | See above for command
clustalo-align.sh | SGE job script for running aligner | custom, HB
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree

