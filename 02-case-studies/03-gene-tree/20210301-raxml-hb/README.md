---
title: Repeat gene tree analysis with new blast homologs
author: Bin He
date: 2021-03-01
---

# Goal
A repeat of the 2021-01-31 analysis (see sister folder) on an updated version of the homologs sequence. The difference between this and the 20210131 analysis is the addition of B9J08_004098, which _was_ included in earlier versions but removed in the previous two analyses in order to keep the _C. auris_ sequences in the homolog list all from one strain (B11221). However, further analysis revealed that the blastp against the refseq_prot database, which has B11221 as the representative for _C. auris_, apparently misses one sequence, as shown in Muñoz 2021 Genetics paper. I further found that one of the _C auris_ sequences recovered by the FungiDB blast (all from B8441) doesn't have a match among the B11221 hits from refseq, and almost surely is the ortholog of the missing B11221 sequence. Therefore I addded it back to the list, using it as a "replacement" for that missing sequence. See `blast/blast.nb.html` for details.

# Notes

## 2021-03-01

To align the sequences, I first did the ClustalO alignment with 50 iterations, which took only a few minutes on 30 slots on ARGON. Instead of running Muscle on the unaligned sequences, I decided to use the `muscle -in <Aligned> -out <Refined> -refine` function as follows:

```bash
muscle -in XP_028889033_homologs_N500_clustalo.faa -out ./XP_028889033_homologs_N500_muscle_refined.faa -refine
```

Note that the above is now part of the `clustalo-align.sh` script. So it's no longer necessary to run it manually.

To extract the first 480 columns in the alignment for tree reconstruction, I used the following commands (now part of the `raxml-muscle.sh`)

```bash
bioawk -c fastx '{print ">"$name;print substr($seq, 1, 480)}' XP_028889033_homologs_N500_muscle_refined.faa > XP_028889033_muscle_refined_C480.faa
```

Lastly I used Notung 2.9 to reconcile the resulting gene tree (used `RAxML_bipartitions.muscle_100381`) with the species tree (`../../../data/20200724-species-tree.nwk`). Rooting analysis was performed in Notung, which scored the the Saccharomycetaceae clade the most likely root. Rearrangement was performed with edge weight (based on rapid bootstrapping) cutoff of 90%. The resulting reconciled and rearranged tree had a total of 44 duplications and 14 losses.

## 2021-11-24

_Motivation_

- In the first version of the manuscript, I knew that I didn't quite resolve the relationships among the Hil homologs in the MDR clade and that the rearrangement performed in Notung probably introduced some artifacts. But I didn't quite pursue that. Instead I left those results as they were and made claims based on them. Now that I'm revising the manuscript and refocusing the paper on the evolution of the family, I feel the need to revisit these problems and get a better picture.

_Approach_

1. To better visualize the relationships between the Hil homologs in the MDR clade -- specifically to tell the relationships between Hil1-8 -- I wrote a `sed` script that can rename sequence or taxa names in text files. I applied it to the RAxML output files in this folder.
2. I repeated Notung analysis and changed the rearrangement cutoff to 80%. This preserves the relationships among the MDR clade, namely Hil5 is the first to diverge and Hil1/2, Hil3/4 and Hil6/8 are pairs of closely releated homologs,  as is concistent with the 07-polymorphism tree.

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
