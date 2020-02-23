---
title: analysis for genome-wide analysis of fungal adhesin prediction
author: Lindsey Snyder
date: 2020-01-29
---

# Examples of markdown format
# this is heading 1
## this is heading 2
### this is heading 3, etc.
- this is an unordered list
    - this is an indented list
1. this is an ordered list
1. I can add an item, and markdown will format for me
1. and you don't have to do the increment
_this is how I italicize_
*this is italicize as well_
**this is how I bold a text**
[some link](yeastgenome.org)
`wrap commands in backsticks`
```
wrap multiple lines of code with three backsticks
```

# 2020-01-29 FungalRV prediction for B11221
1. Divided proteome fasta file into two by the following command
    `split -l #oflines filename`
2. Submit the split files to [FungalRV](fungalrv.igib.res.in/query.php)
    No parameters are needed for this tool.
3. Output saved as csv files in `output/FungalRV` folder

# 2020-01-30 Extract the fasta sequences for FungalRV predicted adhesins
_Goal_

- Take FungalRV predicted adhesin sequences and run them through the second prediction algorithm [FaaPred](http://bioinfo.icgeb.res.in/faap/)
- The positive hits from FaaPred will be our primary set for analysis

_Task_

Use the output from FungalRV to extract the subset of hits into new fasta (thanks Yann for help with these commands!)
1. isolate IDs from FungalRV predicted adhesins list
    `cat B11221_2_fungalRV.txt | awk '{print $1}' > B11221_2_fungalRV_IDs.txt`
1. linearize fasta file
    `awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' B11221_2.fasta > B11221_2_linear.txt`
1. Filter out the predicted adhesins from FungalRV based on ID
    `while read IDS ; do grep "\b$IDS\b" B11221_2_linear.txt ; done < B11221_2_fungalRV_IDs.txt > B11221_2_linear_filtered.txt`
1. rewrap the sequences
    `cat B11221_2_linear_filtered.txt | tr '\t' '\n' > B11221_2_filtered.fasta` 
1. submit the hits to Faapred

# 2020-02-04 HB, tried to put the commands above together in a shell script
Check out the `script` folder.

# 2020-02-09 Faapred prediction for B11221 and B8441
1. Divided positive hits from FungalRV into files with 25 or less sequences (requirement of Faapred) 
1. Submit files to Faapred using default parameters, ACHM model with a threshold of -0.8
1. Output saved in `output/Faapred` folder


# 2020-02-12 FungalRV and FaaPred predictions for *C. albicans* and *C. glabrata*
1. Downloaded RefSeq protein sequences from NCBI on 11 Feb 2020
2. Ran entire proteomes through FungalRV, downloaded all results
3. Followed process outlined in shell script to filter the results **but** the filter step did not work; it returned all of the sequences. Wrote a function in R to do the same thing (recorded in `script` folder)
4. Returned results with Score > 0 for each species, results in `output/FungalRV` folder
5. Divided positive predictions into 25 sequences each with split command above and ran through FaaPred, default ACHM model with a threshold of -0.8
6. Returned results for SVM Score > -0.8 (done in R `left_join` on accession number to the tables returned in previous R function) results in `output/Faapred` folder

Note that I have the full table in R with all of the FungalRV and FaaPred scores if we ever decide we want to change our cutoffs.

# 2020-02-13 Signal peptides predicted using Phobius for all strains
1. Uploaded Faapred output fasta files for each strain to [Phobius](http://phobius.sbc.su.se/index.html) using short output format
1. Filtered sequences with predicted signal peptides
1. Output saved in `output/SignalPeptide`

# 2020-02-13 GPI anchors predicted using GPI-som for all strains
1. Uploaded Faapred output fasta files for each strain to [GPI-som](http://genomics.unibe.ch/cgi-bin/gpi.cgi)
1. Saved GPI anchored sequences in `output/GPIanchor`

# 2020-02-22 Learn about CATH
Created a new folder to document all CATH related stuff. The goal is to use the web service to determine if there are known protein domains in the N-terminal of the predicted adhesins

# 2020-02-23 Switch to genomewide scan code base
Found a useful resource by the CATH authors. Will give it a try. See `analysis/CATH/genomescan` for details.
<https://github.com/UCLOrengoGroup/cath-tools-genomescan>
