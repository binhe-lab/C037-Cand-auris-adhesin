---
title:  Analyze amino acid frequency properties, particularly Cysteine and Dibasic peptide frequency
author: Bin He
date:   2020-03-06
---

The goal is to compare the cysteine and dibasic frequencies in the predicted adhesins vs the rest of the genomes. To do so, I modified the `calc_freq.py` from the script folder to deal with gzipped files, and processed the five genomes we are working on, excluding the two _C. auris_ genomes that are not as well assembled (B6684 and B11243)

I first used the `calc_freq_gz.py` to process all five fasta files manually at the command line, and generated the result files with names such as `C-auris-B11220-genome-freq.txt`

The above was done on 3/2. On 3/6, I modified the code to use a sliding window to record the highest Cystein frequency in a window size of 300 (in the event that the sequence is shorter than the window size, the program simply return the total count in the entire sequence).

See [html preview](https://htmlpreview.github.io/?https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/analysis/amino-acid-composition/amino-acid-composition-analysis.html) for results.
