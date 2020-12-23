---
title: Characterize the adhesin-related properties for the homologs of the _C. auris_ putative adhesin 
author: Bin He
date: 2020-10-31
---

## Overview
This folder was created to repeat the 2020-07-24 analysis with the updated homologs sequences.

## Data
`XP_028889033_homologs.fasta` was copied from `../../blast/XP_028889033_homologs_combine.fasta`, created on 2020-11-14, with the exception that the first 900 amino acid was added back to XP_025344407.1

Compared to the 2020-07-24 version, this version has 99 instead of 100 sequences. Two sequences were dropped -- B9J08_004098_Cauris, which is from a different strain than the one the query is from, and CABR0s31e03938g_Nbracarensis, which is shorter than 500 amino acids but accidentally passed the filter in the previous analysis due to inconsistent metadata from the blast hit table. In the meantime, one _C. glabrata_ sequence was added, i.e. CAGL0L00227g_Cglabrata, whose query coverage is slightly lower than the 50% cutoff (47%) but has all the features of the query protein, including a highly repetitive and serine/threonine rich C-terminal region. Note that the additional _C. glabrata_ sequence was identified through GRYC. It does exist in NCBI database, but is in "provisional" status in the Refseq (XP_002999585).

**update 2020-11-15** CAGL0L00227g is removed. See README in `blast` folder for details.

## Analysis
### FungalRV
I found that the results obtained from the [FungalRV server](http://fungalrv.igib.res.in/query.php) has inconsistencies. The scores differ between the submission with fasta file vs through the input box. Instead, I ran the analysis locally (had to compile the source code for SVM light as the binary downloaded before no longer work on Catalina). I soft linked the homologs fasta file to the `01-global-analysis/script/FungalRV_adhesin_predictor` and generated the output there, and copied it back here.

### FaaPred
The FaaPred results is copied from the 2020-07-24 folder. I manually removed the two lines corresponding to the two sequences removed. The [FaaPred server](http://bioinfo.icgeb.res.in/faap/) was unavailable at the time of my writing. Thus I left it as "NA".

### Fungal GPI pattern (skipped)
> There is a feature on the FungalRV server result, where each sequence has an associated "Search for GPI fungal pattern" link. Upon looking into it, I found it is a simple "fuzzy search" using a quasi-regular-expression very similar to the PROSITE patterns. I think this pattern is simply made by the FungalRV authors. The program used for the search is `fuzzpro`, which is part of the well-known `EMBOSS` suite. I implemented that search locally and get the result using the following command

> ```bash
> fuzzpro -sequence XP_028889033_homologs.fasta -sformat fasta -pattern "[GNSDAC]-[GASVIETKDLF]-[GASV]-X(4,19)-[FILMVAGPSTCYWN](10)>" -outfile fungalGPIanchor.txt
> ```

> The output includes the sequence name, what looks like a FDR-adjusted _P_-value and the predicted cleavage site ($\Omega$ site). For our purpose, we just need the names of the sequences with the second column smaller than or equal to 0.05.

### GPI anchor by GPI-SOM
I decided to skip the GPI-SOM result and use PredGPI instead.

### PredGPI
[Website](http://gpcr.biocomp.unibo.it/predgpi/pred.htm) tool provides a simple interface and the result can be directly downloaded. The result file contains the original fasta sequences, which we don't need. I just used `grep` to only retain the sequence name lines.

### $\Beta$-aggregation sequence counts and intervals

**Update 2020-10-31**
For this updated analysis, since only three sequences were removed/added, I simply created soft links for all tango output files from the 2020-07-24 analysis, and then added the result for the new _C. glabrata_ sequence result. All notes below are from 2020-07-24

_old notes_

Jan and Rachel's talks have shown that a $\Beta$ aggregation signature motif, in the form of "G[VI]{1,4}T{0,4}", is present in XP_028889033 as well as two other homologs. The goal here is to identify all such motifs among all homologs. Here I'll use the same `fuzzpro` program used above to identify GPIanchor to search for this pattern.

To be able to run TANGO myself, I registered an account on the author's [website](http://tango.crg.es/examples.jsp), downloaded the binary for Mac, and wrote a simple python script to format the intput file (`format_tango_input.py`). I used the parameters that Rachel decided based on the literature (see `01-global-adhesin-prediction/output/TANGO` for details). The input file is stored as `XP_028889033_homologs_tango.txt`. In doing so, I found that the tango v2.3.1 I downloaded didn't expect the "tf" parameter. So I removed that part in the input file. This resulted in some differences in the output. To be safe, I asked Rachel to run the same file through her Windows binary and saved the file as a zip archive under the `2020-07-24` folder.

I initially used a different approach from Rachel's. Hers is to write a "bat" file in Windows to call Tango individually on each sequence, while I formated the input file to be taken in by Tango as a whole. To do so, I need to invoke the `tango_2_3_1` binary on the command line, answer "Y" to the question of whether to record individual residue prediction results, and paste in the name of the input file. Then I need to patiently wait for the program to run, during which time it will output a lot of information on the screen in addition to writing the results to the files.

**Update 2020-08-10**
The results from my approach missed 22 sequences in the residue-level predictions, that is, there are only 78 individual result files, even though all 100 sequences are in the aggregated result. I found that the problem was some of the sequence names were too long. Simply cutting them shorter solved the issue. Also, I decided to switch to Rachel's approach of writing a shell batch script so that I can incorpor. To do so, I modified `format_tango_input.py` to only write the sequence ID without the species name, since the former is already unique, and I made the script generate shell scripts. The new python script is called `format_tango_batch.sh`, and it generates an `.sh` file that can be directly run at the command line.

```bash
python3 format_tango_batch.py XP_028889033_homologs.fasta
bash XP_028889033_homologs_tango.sh
```

Because Tango output one file per sequence, to avoid cluttering the results folder, I created a `tango-output` folder for it, and kept the output files gzipped -- my R code can easily read in gzipped files with little runtime cost.

The script used to parse and explore the TANGO results are in `tango.Rmd`

### S/T frequency
1. Use `freak` from EMBOSS suite to calculate the frequency of Serine or Threonine in each of the 100 sequences in the homolog file.

    ```bash
    freak XP_028889033_homologs.fasta -letters "ST" -window 100 -step 10 -outfile ST_freq_100_10.freak -odirectory raw-output
    ```
1. Convert the output to a table format for plotting
    
    ```bash
    python format_freak_out.py raw-output/ST_freq_100_10.freak
    ```

1. Compress the output for storage

    ```bash
    gzip ST_freq*
    ```


1. For plotting, we would like to create a vector of sequence names in the same order as shown in the rooted gene tree. To do so, I loaded the `../gene-tree/20200723-raxml-hb/RAxML_bipartitions.muscle_4318866` in FigTree 1.4.4, rooted the tree on the Saccharomycotaceae, and rotated the auris and albicans groups, then saved the tree in Newick format. I then copied that file over to the current folder and edited in vim. By removing the branch lengths and other symbols such as parentheses, I got the sequence names in rows in the same order as the gene tree.

1. At Jan's suggestion, I expanded the analysis above to separately document the frequency of Serine and Threonine. I also altered the window size and step size to 50 and 5 bp.

### Collect feature profiles for a schematic plot for each homolog

We would like to collect features including Signal peptide (N-terminus), GPI-anchor (C-terminus), NTD Hyp_reg_CWP domain, S/T frequency and TANGO sequences.

#### Signal peptide and GPI-anchor

- See notes before, I discarded the GPI-SOM results altogether and opted to use [SignalP 5.0 server](http://www.cbs.dtu.dk/services/SignalP-5.0/) to predict the N-terminal signal peptide, and use PredGPI (see below) to predict the C-terminal GPI anchor. The new SignalP 5.0 result is now in `raw-output/signalp_5.0.gff`.

- To get the position of the GPI-anchor, I turn to the PredGPI result. An example is shown below:

    ```
    >XP_028889033.1_Cauris | FPrate:0.000 | OMEGA:S-3027
    ```
    Here we get the starting position of the GPI-anchor sequence

#### Hyp_reg_CWP
Refer to 2020-07-24 notes (below) for details. I simply submitted the additional _C. glabrata_ sequence to HMMScan and edited the output.

_old notes_

Some thoughts are, the Pfam site has many of these sequences and have the Pfam cartoon showing the positions of the NTD. Alternatively, I could use the alignment to define the boundaries of the NTD in each homolog. 

What I ended up doing is submitting the sequence to the [HMMSCAN tool](https://www.ebi.ac.uk/Tools/hmmer/search/hmmscan) and selects pfam as the target profile-HMM database. The batch result page didn't provide a link to download the collected hit table. Luckily, I filled in my email address at the time of submission, and the result is emailed to me. This is saved as `raw-output/HMMER-HMMScan-Pfam-hits.tsv`. I edited the header to make it friendly for R.

To understand the output file, I referred to the [HMMER v3 manual](http://eddylab.org/software/hmmer3/3.1b2/Userguide.pdf). When HMMER searches a profile-HMM database, e.g. pfam, with the user-input query sequence(s), it tries to identify the region that matches the domain profiles. In doing so, it will produce three sets of coordinates, two of which refer to the query and one to the profile in the database. For the latter, we have "model start/end/length", which tells us which part of the model (profile) the query matches. For the former, there are the "alignment start/end" and "envelope start/end". The first refers to the best guess of the start and end of the query that matches the domain profile. The second is a slightly wider region that captures most of the posterior probability mass in the HMM run. HMMER usually uses the envelope start and end to annotate the domains in the protein.
### Annotate XP_028889033 with Hyp_reg_CWP, Hyr1 and TANGO sequences
_Goal_

1. Visualize the domain architecture of XP_028889033
1. Determine the relationship between the Hyr1 repeats and the regularly spaced TANGO sequences

_Approach_

To visualize the various domains along with TANGO sequences in Jalview, I followed Jalview's own feature file format and made a feature file for XP_028889033, by exporting the data from R. I then exported png files with or without the Hyr1 and TANGO features on or off, and made a GIF file from them.

```bash
convert -delay 180 20200830*.png -loop 0 20200830-XP_028889033-annotated.gif
```

![XP_028889033 annotated](../2020-07-24/img/20200830-XP_028889033-annotated.gif)

### Cluster TANGO sequences and draw their domain distribution
_Goal_

- Group TANGO sequences based on sequence similarity and plot their group # and distribution along each homolog

_Background reading_

See `00-misc-doc/2020-09-17-beta-aggregation.md`

_Thoughts_

I start to realize that the TANGO hit sequences are not the same as some other sequence-specific motifs such as Pho4 binding sites. The difference lies in that it's the proportion of hydrophobic residues, such as I/V/T, that are important for beta-aggregation. The order in which they appear in a motif matters far less. This means my distance measure could potentially be based on amino acid composition rather than edit or alignment distance. For example, we can quantify the number of I/V, T, G/A and other amino acids. The problem with this approach is that the rule is designed based on the GVVIVTT variants. As such, it won't necessarily cluster alternative motifs.

An idea is to first summarize TANGO sequence within each protein, counting their number of instances and distribution, and see if some alternative patterns emerge.

