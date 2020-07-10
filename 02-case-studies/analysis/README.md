This README serves the dual purpose of documenting any analyses in this folder and also as the general notes for any analyses done, including ones with files in other folders.

## Contents
| File | Description | Source | User |
| ---- | ----------- | ------ | ---- |
| blast.Rmd | BLAST to identify homologs for case gene | symbolic link points to `output/blast/` folder | HB/2020 |

## Notes

### 2020-06-26 [HB] Lindsey's protein alignment and gene tree

_Goal_

- Write a script to automatically extract the first N bp, align and build a gene tree with RAxML.
- Use Notung to reconcile the tree.

_Approach_

1. Edit the alignment to make the gene names compatible with Notung's postfix format, i.e. geneName_speciesName.

### 2020-07-09 [HB] Draw new species tree

_Goal_

To be used with the new alignment that include more species for reconciliation

_Approach_

1. Using the data from the `blast.Rmd` to list the species used:
    ```
    Cauris Chaemuloni Cpseudohaemulonis Cduobushaemulonis Dhansenii Sstipitis Ctropicalis Calbicans Drugosa Cdubliniensis Lelongisporus Clusitaniae Ncastellii Cglabrata Cparadoxus
    ```
1. Write the Newick format tree, with the topology from Shen et al 2018 Cell (PMID: 30415838) and Muñoz et al 2018 Nat. Comm (PMID: 30559369)
    - Interestingly, I found there is some disagreement on the spelling of the species names, e.g. the ncbi database (taxonomy) uses _C. haemuloni_, while the Muñoz 2018 uses _C. haemulonii_ and yet another synonym is _C. haemulonis_. To enable downstream analysis, I'll use what the ncbi database uses.

1. In the course of writing the species tree, I noticed that I made a mistake in writing one of the species names in the `blast.Rmd` code. For "CPAR2" from the fungidb hits, I wrote "Cparadoxus", when it should be "Cparapsilosis". To correct all the mistaken names, I searched for "Cparadoxus" in the `data` and `output/blast,gene-tree` folders with `grep -rl Cparadoxus *` (`-r`: recursive, `-l`: only prints the file name, not the lines with matches). To correct them, I used the following command
    ```bash
    $ sed -i '.bak' 's/Cparadoxus/Cparapsilosis/g' *
    ```
    This command will do in-place string replacement for all files in the current folder, while saving the original files as a bakcup with ".bak" suffix. After verifying that the replacement was successful, I subsequently deleted all the backup files.
