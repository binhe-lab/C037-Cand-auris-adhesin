---
title: Characterize the adhesin-related properties for the homologs of the _C. auris_ putative adhesin 
author: Bin He
date: 2020-07-17
---

## Overview
The overall question in the phylogenetic analysis of the protein family is to understand where did this putative adhesin evolve from, whether its homologs in other species also possess the adhesin properties and how has the protein family expanded or contracted -- whether there is any correlation between the trend of family expansion and pathogenecity potential of the species. My blast analysis was aimed at collecting homologs for this family from related commensal and free-living species. The gene tree reconstruction was to infer the evolutionary relationship between those sequences to infer the duplication and loss events in each species. Now I'd like to collect adhesin related properties for all the homologs, including FungalRV prediction, FaaPred, GPI-anchor & Signal peptide and MEME/XSTREM (for repeats). Once these statistics are gathered, the goal is to combine them in a data frame and plot them using the ggtree package.

This folder was created to repeat the 2020-07-17 analysis with the updated homologs sequences.

## Data
`XP_028889033_homologs.fasta` was copied from `../../blast/XP_028889033_homologs_combine.fasta`, created on 2020-07-23, with the exception that the first 900 amino acid was added back to XP_025344407.1

## Analysis
### FungalRV
I found that the results obtained from the [FungalRV server](http://fungalrv.igib.res.in/query.php) has inconsistencies. The scores differ between the submission with fasta file vs through the input box. Instead, I ran the analysis locally (had to compile the source code for SVM light as the binary downloaded before no longer work on Catalina).

### FaaPred
Split the fasta sequence file into subsets of 25 using `split -l 50 XP_028889033_homologs.fasta`. Submit the 5 subset files to the FaaPred [website app](http://bioinfo.icgeb.res.in/faap/query.html), copy and paste the results into Sublime Text and removed the first index column, resulting in the `raw-output/faapred_result.txt`.

### Fungal GPI pattern (skipped)
> There is a feature on the FungalRV server result, where each sequence has an associated "Search for GPI fungal pattern" link. Upon looking into it, I found it is a simple "fuzzy search" using a quasi-regular-expression very similar to the PROSITE patterns. I think this pattern is simply made by the FungalRV authors. The program used for the search is `fuzzpro`, which is part of the well-known `EMBOSS` suite. I implemented that search locally and get the result using the following command

> ```bash
> fuzzpro -sequence XP_028889033_homologs.fasta -sformat fasta -pattern "[GNSDAC]-[GASVIETKDLF]-[GASV]-X(4,19)-[FILMVAGPSTCYWN](10)>" -outfile fungalGPIanchor.txt
> ```

> The output includes the sequence name, what looks like a FDR-adjusted _P_-value and the predicted cleavage site ($\Omega$ site). For our purpose, we just need the names of the sequences with the second column smaller than or equal to 0.05.

### GPI anchor by GPI-SOM
The [GPI-SOM](http://genomics.unibe.ch/cgi-bin/gpi.cgi) web-tool appears to be down. No matter whether I submit a single sequence through the input box or by uploading a fasta file, the output is always an error "GPI-SOM wasn't able to process all input sequences." Given the similar results from GPI-SOM and PredGPI for the 2020-07-14 result, I decide to skip this one.

Update [2020-07-26]: the server is back to being functional. Followed the same analysis pipeline as in the 2020-07-17 analysis.

### PredGPI
[Website](http://gpcr.biocomp.unibo.it/predgpi/pred.htm) tool provides a simple interface and the result can be directly downloaded. The result file contains the original fasta sequences, which we don't need. I just used `grep` to only retain the sequence name lines.

### $\Beta$-aggregation sequence counts and intervals
Jan and Rachel's talks have shown that a $\Beta$ aggregation signature motif, in the form of "G[VI]{1,4}T{0,4}", is present in XP_028889033 as well as two other homologs. The goal here is to identify all such motifs among all homologs. Here I'll use the same `fuzzpro` program used above to identify GPIanchor to search for this pattern.

To be able to run TANGO myself, I registered an account on the author's [website](http://tango.crg.es/examples.jsp), downloaded the binary for Mac, and wrote a simple python script to format the intput file (`format_tango_input.py`). I used the parameters that Rachel decided based on the literature (see `01-global-adhesin-prediction/output/TANGO` for details). The input file is stored as `XP_028889033_homologs_tango.txt`. In doing so, I found that the tango v2.3.1 I downloaded didn't expect the "tf" parameter. So I removed that part in the input file. This resulted in some differences in the output. To be safe, I asked Rachel to run the same file through her Windows binary and saved the file as a zip archive under the `2020-07-24` folder.

Diferent from Rachel's approach, which is to write a "bat" file in Windows to call Tango individually on each sequence, I formated the input file to be taken in by Tango as a whole. To do so, I need to invoke the `tango_2_3_1` binary on the command line, answer "Y" to the question of whether to record individual residue prediction results, and paste in the name of the input file. Then I need to patiently wait for the program to run, during which time it will output a lot of information on the screen in addition to writing the results to the files.

Because Tango output one file per sequence, to avoid cluttering the results folder, I created a `tango-output` folder for it, and kept the output files gzipped -- my R code can easily read in gzipped files with little runtime cost.

The script used to parse and explore the TANGO results are in `tango.Rmd`
