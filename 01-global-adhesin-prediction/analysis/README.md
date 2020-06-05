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

## 2020-01-29 [LFS] FungalRV prediction for B11221
1. Divided proteome fasta file into two by the following command
    `split -l #oflines filename`
2. Submit the split files to [FungalRV](fungalrv.igib.res.in/query.php)
    No parameters are needed for this tool.
3. Output saved as csv files in `output/FungalRV` folder

## 2020-01-30 [LFS] Extract the fasta sequences for FungalRV predicted adhesins

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

## 2020-02-04 [HB] tried to put the commands above together in a shell script
Check out the `script` folder.

## 2020-02-09 [LFS] Faapred prediction for B11221 and B8441
1. Divided positive hits from FungalRV into files with 25 or less sequences (requirement of Faapred) 
1. Submit files to Faapred using default parameters, ACHM model with a threshold of -0.8
1. Output saved in `output/Faapred` folder


## 2020-02-12 [RS] FungalRV and FaaPred predictions for *C. albicans* and *C. glabrata*
1. Downloaded RefSeq protein sequences from NCBI on 11 Feb 2020
2. Ran entire proteomes through FungalRV, downloaded all results
3. Followed process outlined in shell script to filter the results **but** the filter step did not work; it returned all of the sequences. Wrote a function in R to do the same thing (recorded in `script` folder)
4. Returned results with Score > 0 for each species, results in `output/FungalRV` folder
5. Divided positive predictions into 25 sequences each with split command above and ran through FaaPred, default ACHM model with a threshold of -0.8
6. Returned results for SVM Score > -0.8 (done in R `left_join` on accession number to the tables returned in previous R function) results in `output/Faapred` folder

Note that I have the full table in R with all of the FungalRV and FaaPred scores if we ever decide we want to change our cutoffs.

## 2020-02-13 [LFS] Signal peptides predicted using Phobius for all strains
1. Uploaded Faapred output fasta files for each strain to [Phobius](http://phobius.sbc.su.se/index.html) using short output format
1. Filtered sequences with predicted signal peptides
1. Output saved in `output/SignalPeptide`

## 2020-02-13 [LFS] GPI anchors predicted using GPI-som for all strains
1. Uploaded Faapred output fasta files for each strain to [GPI-som](http://genomics.unibe.ch/cgi-bin/gpi.cgi)
1. Saved GPI anchored sequences in `output/GPIanchor`

## 2020-02-22 [HB] Learn about CATH
Created a new folder to document all CATH related stuff. The goal is to use the web service to determine if there are known protein domains in the N-terminal of the predicted adhesins

## 2020-02-23 [HB] Switch to genomewide scan code base
Found a useful resource by the CATH authors. Will give it a try. See `script/CATH/genomescan` for details.
<https://github.com/UCLOrengoGroup/cath-tools-genomescan>

## 2020-02-26 [RS] Upload first version Rmarkdown file
Uploaded the first version of the Rmarkdown file to create master results table

## 2020-02-27 [HB] amino acid composition
_Goal_

Compute the frequency of cysteine and dibasic motifs in predicted adhesins

_Notes_

1. Initially I used the `compseq` program in EMBOSS 6.6.0. But I later realized that for what we need to do, grep is sufficient
1. Rewrote the script in Python, much more elegant and more efficient.
1. Now that my script can efficiently compute these statistics, I wonder how does the distribution of the two properties for the predicted adhesins compare to that of the entire genome.
1. Created a new folder in `analysis` and used a modified python code to calculate the frequencies for the 7 genomes. To be continued with analysis in R

## 2020-03-02 [HB] amino acid composition, preliminary result
I did a preliminary analysis comparing the counts of cysteine and dibasic residues in the predicted adhesins vs. the rest of the genome. To control for protein length, I stratified the proteins by length into five groups. Plotting the number of both types of residues showed that the predicted adhesins had **less**, not **more** than the rest of the genome.

## 2020-03-03 [HB] amino acid composition, revisit
I talked to Jan, who suggested comparing the frequency of both types of motifs against the naive expectation of 1/20, assuming each amino acid is equally used in the proteome. My current thinking is that for cysteine, we probably should look at a sliding window (maybe 300bp) and record the highest percentage per protein. This would correspond to the "Cysteine-rich region" definition. As for the dibasic motif, perhaps there is no need comparing them to the other proteins, but rather just score 0 or 1 (has or don't have). Jan also suggested using the [Eukaryotic Linear Motif (ELM)](http://elm.eu.org/index.html) database, which uses regular expression to search for linear protein motifs. There, the regular expression for protease digestion site is often more than the [RR|KK|RK|KR].

## 2020-03-09 [HB] Orthogroup, cluster
What is the evolutionary relationship between the predicted adhesins in _C. auris_ vs those in _C. albicans_? The underlying question is, did _C. auris_ and _C. albicans_ inherit and largely share the same group of adhesin genes, or did each species evolve (exapt or co-opt) new ones on their own? To answer this question, I thought of several approaches:

1. [CD-HIT](http://weizhongli-lab.org/cd-hit/), which uses exact matches of short words to estimate sequence similarity without actually aligning them. It is a very popular tool to reduce a large sequence set to "representative sequences". FaaPred used it to first reduce the set of positive adhesin sequences before training the SVM on it.
1. BLAST reciprocol best hits (RBH). This is widely used as a proxy for homology. Many different workflows exist to implement the idea.
1. Ortho Groups. The [Fungal Orthogroup](https://portals.broadinstitute.org/regev/orthogroups/), which I uses frequently, is one such example. I found that EuPathDB has a sub-site that is called [OrthoDB](https://orthomcl.org/orthomcl), which has a workflow for mapping user defined proteins to pre-computed Orthogroups. This is what I ended up following. See `output/OrthoMCL` folder for details.
## 2020-03-20 [HB] Re-ran OrthoMCL mapping for all fungalRV predicted adhesins

1. Concatenated all FungalRV predicted adhesins to a single fasta file
1. Upload onto [OrthoMCL galaxy site](https://veupathdb.globusgenomics.org/) and run the pipeline
1. There are two result files, the `MCS.tabular` and the `mappedGroups.txt`. The former contains sequences not mapped to any existing Orthogroups, and are further clustered using the MCS algorithm.
1. I manually edited the `MCS.tabular` so that each row is a protein sequence and the same cluster (at most three in a cluster) gets an arbitrary MCS_# number.
1. On Galaxy OrthoMCL pipeline, I varied the "inflation" parameter for the MCS program according to the program's suggestion. the default is 4, and I changed it 1.4 and 2.0  Neither changed the results.

## 2020-04-28 [HB] Reboot the project

_Summary of previous work_

1. I have submitted all FungalRV predicted adhesins to OrthoMCL. This essentially maps all the adhesins to an existing classification system. The MCL group ID can be used to group the adhesins and, to some extent, answer the question of whether the predicted adhesins in different species "come from the same set of ancestral genes".
1. CATH results in the `../script/CATH/` folder provides protein domain information, which gives another way to answer the above question
1. Rachel has collected PFAM data, which is another potential source of information.

_Todo_

1. Dig deeper into the OrthoMCL results
1. Combine CATH AND Pfam information and get a clearer picture.

_Notes_

For more details on this part, check the README file in the `protein-family-classification` subfolder.

## 2020-05-26 [HB] Low complexity repeats, why and how

As I was re-reading the Lipke 2018 review, I was trying to understand why LCR is a characteristic of adhesins and what function could it serve. I came upon two papers by Kevin Verstrepen, a yeast geneticist trained with Gerry Fink at MIT, and found his work incredibly interesting. The references are below. In the second paper, he expressed eight natural variants of the _FLO1_ gene from _S. cerevisiae_ and ectopically expressed each one of them in the lab strain S288C, where all five endogenous flocculins are transcriptionally silent. He found that _FLO1_ alleles with a longer track of repeats, when expressed, made the cells more sticky!

Here are the notes I made for the first paper:

1. 44 / 6,591 ORFs in the budding yeast genome contain long (>40nt) or short (3-39nt) repeats.
2. genes with repeats share surprising functional similarities: 75% of the 29 ORFs with long repeats encode cell surface proteins, while many of the ORFs with short repeats are regulatory proteins for cell wall synthesis
3. the intragenic repeat regions are all in-frame, thus their expansion and contraction will not cause frameshifts
4. length of the intragenic repeat regions are highly variable within the species
5. the intragenic repeat sequences are hotspots for recombination.
6. longer repeats in _FLO1_ correlates with stronger adherence!

_References_
Verstrepen KJ, Jansen A, Lewitter F, Fink GR. 2005. Intragenic tandem repeats generate functional variability. Nature Genetics [Internet] 37:986–990.

Verstrepen KJ, Klis FM. 2006. Flocculation, adhesion and biofilm formation in yeasts. Molecular Microbiology [Internet] 60:5–15.

## 2020-05-29 [HB] Next-step questions
see `protein-family-classification/README.md` for details.

## 2020-06-05 [HB] Todo list
1. Merge _S. cerevisiae_ results, add FaaPred flag, and repeat the orthomcl results
    - percent of predicted adhesins mapped
    - merge the three _C. auris_ adhesin sets
    - proportion of predicted adhesins belonging to an orthogroup that is shared by at least two genomes
1. Examine top orthogroup functions
