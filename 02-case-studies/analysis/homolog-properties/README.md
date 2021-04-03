---
title: Characterize the adhesin-related properties for the homologs of the _C. auris_ putative adhesin 
author: Bin He
date: 2020-07-17
---

## Overview
The overall question in the phylogenetic analysis of the protein family is to understand where did this putative adhesin evolve from, whether its homologs in other species also possess the adhesin properties and how has the protein family expanded or contracted -- whether there is any correlation between the trend of family expansion and pathogenecity potential of the species. My blast analysis was aimed at collecting homologs for this family from related commensal and free-living species. The gene tree reconstruction was to infer the evolutionary relationship between those sequences to infer the duplication and loss events in each species. Now I'd like to collect adhesin related properties for all the homologs, including FungalRV prediction, FaaPred, GPI-anchor & Signal peptide and MEME/XSTREM (for repeats). Once these statistics are gathered, the goal is to combine them in a data frame and plot them using the ggtree package.

## Analysis
| Folder | Content |
| ------ | ------- |
| 2020-07-17| version 1 of the analysis|
| 2020-07-24| version 2, with new homologs in the Saccharomycetaceae family (e.g. Nakaseomyces)|

Below are notes for the original analysis. Updated notes will be in the respective folder.

### FungalRV
Submitted the fasta sequence to the [FungalRV server](http://fungalrv.igib.res.in/query.php). The result was downloaded as a tab-delimited table `20200717-fungalRV.txt`.

### FaaPred
Split the fasta sequence file into subsets of 25 using `split -l 50 XP_028889033_homologs.fasta`. Submit the 5 subset files to the FaaPred [website app](http://bioinfo.icgeb.res.in/faap/query.html), copy and paste the results into Sublime Text and removed the first index column, resulting in the `raw-output/faapred_result.txt`.

### Fungal GPI pattern using a regular expression search
There is a feature on the FungalRV server result, where each sequence has an associated "Search for GPI fungal pattern" link. Upon looking into it, I found it is a simple "fuzzy search" using a quasi-regular-expression very similar to the PROSITE patterns. I think this pattern is simply made by the FungalRV authors. The program used for the search is `fuzzpro`, which is part of the well-known `EMBOSS` suite. I implemented that search locally and get the result using the following command

```bash
fuzzpro -sequence XP_028889033_homologs.fasta -sformat fasta -pattern "[GNSDAC]-[GASVIETKDLF]-[GASV]-X(4,19)-[FILMVAGPSTCYWN](10)>" -outfile fungalGPIanchor.txt
```

The output includes the sequence name, what looks like a FDR-adjusted _P_-value and the predicted cleavage site ($\Omega$ site). For our purpose, we just need the names of the sequences with the second column smaller than or equal to 0.05.

### GPI anchor by GPI-SOM
[Website](http://genomics.unibe.ch/cgi-bin/gpi.cgi) tool provides four downloadable outputs:
- `raw-output/gpi-som.txt`: GPI-SOM log file, includes the names of all the sequences with a predicted C-terminal GPI signal sequence.
- a list of sequences with undetermined results -- not applicable to our case.
- `raw-output/gpi-anchored-list.txt`: Names of the sequences predicted to be "GPI-anchored", because "they have both C- and N-terminal signal sequences". I removed the amino acid sequences from the output with `grep`.
- `raw-output/signalp.txt`: output of Signal P prediction used to determine the N-terminal signal peptide.

My understanding is that for a protein to be "GPI-anchored", it needs to have two signal sequences. The N-terminal signal peptide targets the protein for the plasma membrane, and the C-terminal GPI signal sequence allows the substitution of that sequence for the modified GPI-anchor so that the protein can be "fastened" on the cell wall. So the most salient output of this program is just a Y/N answer for each sequence.

86 / 110 submitted sequences were found to encode a C-terminal GPI-signal sequence, and 83 of them also have a predicted N-terminal signal peptide.

### $\Beta$-aggregation sequence counts and intervals
Jan and Rachel's talks have shown that a $\Beta$ aggregation signature motif, in the form of "G[VI]{1,4}T{0,4}", is present in XP_028889033 as well as two other homologs. The goal here is to identify all such motifs among all homologs. Here I'll use the same `fuzzpro` program used above to identify GPIanchor to search for this pattern.

I also got Rachel's help to run TANGO locally on all the sequences. See `01-global-adhesin-prediction/output/TANGO` for details. The input file is stored as `XP_028889033_homologs_TANGO.bat` and the output is a zip file in `raw-output/`. The script to parse the result is in `01-global-adhesin-prediction/script/R%20TANGO_summaries.Rmd`.

To get some quick result, I wrote a simple script called `myfuzzpro.py`, which mimics the `fuzzprot` program in the EMBOSS suite. using this tool with the regular expression pattern derived from both Jan and Rachel's presentation -- `G?[AVI][VI]{3}T[TA]` -- I was able to export the locations of the matches within each of the 110 sequences. I added an option in the script so that the output can be formatted for the [feature map](http://rsat-tagc.univ-mrs.fr/rsat/feature-map.cgi) program as part of the RSAT suite of online apps. The program is able to produce a visual representation of any arbitrary features, which is quite useful.

In order to make the results more useful, I need to order them based on the order they appear in the gene tree. To do so, I first manually edited a gene tree newick format file by removing all branch lengths, parentheses and other characters that are not part of the sequence names. After converting the file to a list of sequence names by line, I reordered them manually to match the order they appear in the gene tree. The result is `RAxML_bipartitions.muscle_4005290_rooted_FigTree_order.txt`. I then sorted the input file based on this order using the same `extract_fasta.py` script I wrote before, and ran the `myfuzzprot` program on the output.

```bash
python extract_fasta.py XP_028889033_homologs.fasta RAxML_bipartitions.muscle_4005290_rooted_FigTree_order.txt
python myfuzzpro.py 
```

### S/T frequency
1. Use `freak` from EMBOSS suite to calculate the frequency of Serine or Threonine in each of the 100 sequences in the homolog file.

    ```bash
    freak XP_028889033_homologs.fasta -letters "ST" -window 100 -step 10 -outfile ST_freq_100_10.freak -odirectory raw-output
    ```
1. Convert the output to a table format for plotting
    
    ```bash
    python format_freak_output.py raw-output/ST_freq_100_10.freak
    ```

1. Compress the output for storage

    ```bash
    gzip ST_freq*
    ```

1. For plotting, we would like to create a vector of sequence names in the same order as shown in the rooted gene tree. To do so, I loaded the `../gene-tree/20200723-raxml-hb/RAxML_bipartitions.muscle_4318866` in FigTree 1.4.4, rooted the tree on the Saccharomycotaceae, and rotated the auris and albicans groups, then saved the tree in Newick format. I then copied that file over to the current folder and edited in vim. By removing the branch lengths and other symbols such as parentheses, I got the sequence names in rows in the same order as the gene tree.

1. At Jan's suggestion, I expanded the analysis above to separately document the frequency of Serine and Threonine. I also altered the window size and step size to 50 and 5 bp.
