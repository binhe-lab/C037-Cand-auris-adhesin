This README serves the dual purpose of documenting any analyses in this folder and also as the general notes for any analyses done, including ones with files in other folders.

## Contents
| File | Description | Source | User |
| ---- | ----------- | ------ | ---- |
| blast.Rmd | BLAST to identify homologs for case gene | symbolic link points to `output/blast/` folder | HB/2020 |

## Notes
Notes about specific analyses are often stored in the README files in their respective folder, e.g. `output/gene-tree/`
Here I store notes and ideas not easily classified under any output folder.

### 2020-08-23 [HB] clustering $Beta$-aggregation sequence motifs identified by TANGO
Some thoughts:

- I tried string distance measures, which are agnostic to the physichemical properties of the amino acids. What they are good at is the ability to handle insertion/deletion and substitutions.
- I'd like to try an alternative method, which is to first construct an alignment with these extremely short sequences, and 

### 2020-08-27 [HB] Collect features for the homologs and plot "schematic" for all of them
The idea is to construct a cartoon to illustrate the key features in each of the homologs, including the predicted signal peptide, GPI-anchor, Hyp_reg_CWP domain. Other features that are not a range but rather quantitative values, e.g. S/T frequency and distribution of $beta$-aggregation sequences can either be plotted on the same or in a separate figure.
