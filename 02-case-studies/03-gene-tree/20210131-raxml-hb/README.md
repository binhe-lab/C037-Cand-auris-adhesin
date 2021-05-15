---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2021-01-31
---

# Goal
A repeat of the 2020-11-14 analysis (see sister folder) on an updated version of the homologs sequence. The difference between this and the 20201114 analysis is the addition of several refseq_prot hits that were missed previously due to the combination of query length and query coverage cutoff. See `blast/blast.nb.html` for details.

# Notes

**update 2021-02-14**

> I reran the raxml analysis because the first run result deviates from my expectation. In particular, the outgroup is not as clear cut, with Clusitaniae sequences mixed with the Nakaseomyces and K. lactis being the outgroup. However, after I ran the reconciliation and rearrangement in Notung, the tree made a lot more sense. Nonetheless I'd like to examine how reproducible the initial problematic branches are in a rerun.

To align the sequences, I first did the ClustalO alignment with 50 iterations, which took only a few minutes on 30 slots on ARGON. Instead of running Muscle on the unaligned sequences, I decided to use the `muscle -in <Aligned> -out <Refined> -refine` function as follows:

```bash
muscle -in XP_028889033_homologs_N500_clustalo.faa -out ./XP_028889033_homologs_N500_muscle_refined.faa -refine
```

This took no time to complete, but upon inspecting the output, there seems to be very minimal changes. Nonetheless, I decided to run RAxML on the Muscle-aligned version, this time only on the first 480 columns of both alignments.

To extract the first 480 columns in the alignment for tree reconstruction, I used the following commands (now part of the `raxml-muscle.sh`)

```bash
bioawk -c fastx '{print ">"$name;print substr($seq, 1, 480)}' XP_028889033_homologs_N500_muscle_refined.faa > XP_028889033_muscle_refined_C480.faa
```

Lastly I used Notung 2.9 to reconcile the resulting gene tree (used `RAxML_bipartitions.muscle_100381`) with the species tree (`../../../data/20200724-species-tree.nwk`). Rooting analysis was performed in Notung, which scored the the Saccharomycetaceae clade the most likely root. Rearrangement was performed with edge weight (based on rapid bootstrapping) cutoff of 90%. The resulting reconciled and rearranged tree had a total of 44 duplications and 14 losses.

# Results files
file(s) | description | source 
------- | ----------- | ------
XP_028889033_homologs_N500.faa | homologs sequences | copied from `../blast/`
XP_028889033_homologs_N500_clustalo.faa | aligned fasta using clustalo | result from clustalo-align.sh
XP_028889033_homologs_N500_muscle_refined.faa | refined the above alignment using muscle | `muscle -in XP_028889033_homologs_N500.faa -out XP_028889033_homologs_N500_muscle_refined.faa -refine`
XP_028889033_muscle_refined_C480.faa | Extracted first 480 columns from the above file | See above for command
clustalo-align.sh | SGE job script for running aligner | custom, HB
raxml-*.sh | SGE job script for running RAxML | custom, HB
RAxML_info* | run info of RAxML | RAxML
RAxML_bestTree* | best scoring ML tree | RAxML
RAxML_bootstrap* | all Rapid Bootstrapping trees | RAxML
RAxML_bipartitions* | best scoring ML tree with support values stored as node labels | RAxML
RAxML_bipartitionsBranchLables* | best scoring ML tree with support values stored as branch labels | RAxML, not supported by FigTree
