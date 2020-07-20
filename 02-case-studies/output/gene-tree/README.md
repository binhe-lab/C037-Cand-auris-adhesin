---
title: 
author: Bin He
date: 
categories:
tags:
---

## Content
Gene geneaology analysis for the XP_028889033 protein family. The subfolders correspond to different iterations of the analysis. Notes on the analysis are either in the README file within the subfolders, or in the README of the analysis folder.
- `20200626-mega-lfs`: this is the earliest analysis that is largely based on Lindsey's course project from 2019 Bioinformatics
- `20200629-raxml-hb`: this is Bin's first attempt to use RAxML to construct a gene tree. The sequences were from Lindsey's alignment
- `20200706-raxml-hb`: this and the next folder contain results using the expanded list of homologs Bin assembled. the difference between the two is that the 20200706 folder is based on the alignment of the first 500 amino acids, while the `20200707` folder further extracts the first 500 columns of that alignment (to remove poorly aligned columns). The results are expected to be rather similar.
- `20200707-raxml-hb`: see above.
- `20200714-raxml-hb`: remove _D. rugosa_ and repeat the alignment and tree construction.
- `20200716-reconciled-hb`: reconcile the gene tree with the species tree above using Notung 2.9.

## Notes
The notes are now kept closely to where the analysis results are. See enclosing sub-folders.
### 2020-06-26 [HB] Lindsey's protein alignment and gene tree

_Goal_

- Write a script to automatically extract the first N bp, align and build a gene tree with RAxML.
- Use Notung to reconcile the tree.

_Approach_

1. Edit the alignment to make the gene names compatible with Notung's postfix format, i.e. geneName_speciesName.

### 2020-06-28 [HB] Learn to use RAxML
See `00-misc-doc/2020-06-28-learn-to-use-RAxML.md` for details

### 2020-07-06 [HB] alignment
See `20200706-raxml-hb`
- After constructing the clustalo alignment, I found one of the sequences jump out as being poorly aligned (XP_025344407.1 from _C. haemuloni_). However, upon checking its blast e-value, I found it aligne with the querry very well, with 5e-149 e-value, 56% query coverage and 77.5% identity. I then discovered the issue: this sequence appears to be the single outlier in that the match in the subject sequence is not in the N-terminus, but in the middle of this unusally long protein (~4400 aa, with most of the other sequences between 328-3300, with median of 940.5 aa and 90% percentile at 1912.5 aa). Since my truncate and align program first truncates each protein at the 500 aa mark, it is not surprising that this sequence would fail to align. To correct this problem, I deleted the first 900 aa of this sequence and saved the new file as `XP_028889033_homologs_combine_edited.fasta` and reran the `truncate-align.sh` program with this file as input.

### 2020-07-09 [HB] Draw new species tree

_Goal_

To be used with the new alignment that include more species for reconciliation

_Approach_

1. Using the data from the `blast.Rmd` to list the species used:
    ```
    Cauris Chaemuloni Cpseudohaemulonis Cduobushaemulonis Dhansenii Sstipitis Ctropicalis Calbicans Drugosa Cdubliniensis Lelongisporus Clusitaniae Ncastellii Cglabrata Cparadoxus
    ```
1. Write the Newick format tree, with the topology from Shen et al 2018 Cell (PMID: 30415838), Muñoz et al 2018 Nat. Comm (PMID: 30559369), Mixão et al 2019 G3 (PMID: 31575637) and O'Brien et al 2018 PLoS One (PMID: 29944657).
    - Interestingly, I found there is some disagreement on the spelling of the species names, e.g. the ncbi database (taxonomy) uses _C. haemuloni_, while the Muñoz 2018 uses _C. haemulonii_ and yet another synonym is _C. haemulonis_. To enable downstream analysis, I'll use what the ncbi database uses.

_Issues_
1. In the course of writing the species tree, I noticed that I made a mistake in writing one of the species names in the `blast.Rmd` code. For "CPAR2" from the fungidb hits, I wrote "Cparadoxus", when it should be "Cparapsilosis". To correct all the mistaken names, I searched for "Cparadoxus" in the `data` and `output/blast,gene-tree` folders with `grep -rl Cparadoxus *` (`-r`: recursive, `-l`: only prints the file name, not the lines with matches). To correct them, I used the following command
    ```bash
    $ sed -i '.bak' 's/Cparadoxus/Cparapsilosis/g' *
    ```
    This command will do in-place string replacement for all files in the current folder, while saving the original files as a bakcup with ".bak" suffix. After verifying that the replacement was successful, I subsequently deleted all the backup files.

1. The references cited don't always agree on the species tree topology. In particular, the placement of _Debaryomyces hansenii_ and _Diutina rugosa_ are controversial. In Shen et al 2018 as well as in the NCBI taxonomy browser, _D. hansenii_ is placed together with the _C. albicans_ clade, forming a sister group with the _C. auris_ clade. In the other two papers and many others I can find in the recent literature on the molecular phylogeny of this group of species, _D. hansenii_ is more closely related to the _C. auris_ group than to _C. albicans_ clade. Another controversial species is _D. rugosa_. In the third paper above, it is placed as an outgroup to the _C. auris_ and _C. albicans_ clade, while the fourth and last paper above found it to be an outgroup to _C. albicans_ and _S. stipitis_, but is still more closely related to those two species than to the _C. auris_ group.

    I decide to go with the most recent tree from Mixão et al 2019, which was constructed using a concatenated alignment of 469 single genes, and seem to have strong bootstrap support. However, I would like to keep an eye on the reconciled and rearranged gene tree to see whether an alternative topology may reduce the total number of gene gains and losses for the XP028889033 family.

### 2020-07-15 [HB] Remove _D. rugosa_ sequences
After attempting to write the species tree for reconciling the gene tree, I found that the new species I introduced in this round of blast, _D. rugosa_, could introduce polytomy to the species tree due to conflicting reports on its phylogenetic position (see `../README.md` notes on writing new species tree). For this reason I decide to remove the _D. rugosa_ sequences, realign and repeat the gene tree reconstruction.

For removing the _D. rugosa_ sequences, I simply edited `XP_028889033_edited_N500.faa` using vim, with `vim "Drugosa" % | cw` to find all the relevant sequences and manually delete them.

To align the sequences, I first did the ClustalO alignment with 50 iterations, which took 3 hours on 10 slots on ARGON. Instead of running Muscle on the unaligned sequences, I decided to use the `muscle -in <Aligned> -out <Refined> -refine` function. This took no time to complete, but upon inspecting the output, there seems to be very minimal changes. Nonetheless, I decided to run RAxML on both, this time only on the first 530 columns of both alignments.
