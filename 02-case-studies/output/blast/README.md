---
title: Use BLAST to identify homologs for XP_028889033.1
author: Bin He
date: 2020-07-01
---

## Goal

- Repeat the blast step to clean up the homologs list.
    some species were missing while others, like _C. albicans_, had more than one strain represented in Lindsey's version.


## Content
File | Description | Source | User/Date
-----|-------------|--------|----------
XP_028889033_homologs_hb.fasta | New blast results, 95 sequences | fungidb, see notes below | HB/2020
XP_028889033_homologs_hb_table.tsv | Accompanying meta data for the file above | fungidb | HB/2020
XP_028889033_homologs_hb_use.fasta | filtered list with length > 500, 82 sequences | fungidb, see notes below | HB/2020


## Notes
### 2020-07-01 [HB] Repeat BLAST to identify XP_028889033 homologs
#### FungiDB
Used the beta version of the new site on 2020-07-01

- Used first 500 aa of XP_028889033 as query, e-value cutoff set to 1e-5, low complexity on, and limit the organisms to the CUG clade, _S. cerevisiae_, _C. glabrata_ and _S. pombe_
- Downloaded 97 sequences along with a table with meta information.
- After examining the meta data, I noticed that some sequences are much shorter than others. I then plotted protein length as a function of e-value, both in log scales, and it became apparent that those sequences below 500 amino acids are the ones with the lowest e-values. I thus removed them by printing a list of gene IDs, and used the `extract_fasta.py` program to output the filtered list.
    ![length-vs-e-value](20200701-XP_028889033-homologs-e-value-by-length.png)

#### NCBI blast
1. `blastp`, e-value cutoff 1e-5, low complexity sequences masked (there is now an option to only mask the low complexity region when generating the seed, but leave them be during the extension).
1. I also tried `Delta-blastp`, which first searches against the conserved domain database and then gather sequences with that domain. This resulted in way too many hits. Didn't pursue further.
1. For the `blastp` results, I further required the query coverage to be greater than 50%, which yielded 144 sequences. I downloaded all of them.
