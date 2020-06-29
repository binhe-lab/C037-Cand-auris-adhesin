# Description

This folder stores the OrthoMCL v5 mapping results. The `.tabular` and `.txt` files with names including `mappedGroups`, `blastp`, `self-blastp`, `paralogPairs` and `MCS` are from the OrthoMCL "Mapping your protein to the orthogroup" tool, implemented as part of the the VEuPath Galaxy site.

In addition, this folder also stores subsets of protein sequences, their alignment and gene tree belonging to selected orthogroups. The goal is to examine the phylogenetic relationship between orthogroup members in the four species. See below for details.

# Content
## 2020-06-06 [HB] align and tree reconstruction
1. Sequence names were stored in the `OG5_xxxxxx.txt` file, which was exported from R (`../../../analysis/protein-family-classification/OrthoMCL-v2.Rmd`).
1. The `faa` file was generated using the `extract_fasta.py` script.
1. The fasta file was opened in Jalview, and the first 499 aa of each sequence were selected and exported to a new window (I intend to make this part of the `extract_fasta.py` as an additional option).
1. ClustalO was used to aligne the newly created file within Jalview, with **50 combined iterations and 1 guide tree**. The aligned file was stored as `OG5_132045_N500_aln.faa`
1. Run RaxML

    I installed RaxML based on the instruction 

    ```bash
    $ raxmlHPC-PTHREADS-SSE3 -m PROTGAMMAWAG -p 12345 -s OG5_132045_N500_aln.faa.fa -# 20 -n test
    ```

    Parameters based on [RaxML Manual v8.2.X](https://cme.h-its.org/exelixis/resource/download/NewManual.pdf)

    > `-m` protein substitution matrix; `-p` random number seed; `-s` input sequence; -# specify the number of alternative runs on distinct starting trees,  e.g., if ­# 10 or ­N 10 is specified, RAxML will compute 10 distinct ML trees starting from 10 distinct randomized maximum parsimony starting trees

    Results are stored in a folder named "raxml" under the respective sub folder.

    The most important files are the `info`, `log` and `bestTree`

## 2020-06-27 [HB] run raxml on ARGON
Some results are dumped in the `OG5_132045`. For details, see main `README.md` under the `analysis` folder.
