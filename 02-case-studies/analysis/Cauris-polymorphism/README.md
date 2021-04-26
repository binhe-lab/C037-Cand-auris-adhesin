## Introduction
This analysis is inspired by a discussion at the poster session during the 2021 Candida and Candidiasis meeting. One of the questions that come up was whethere there are intra-species variation especially in the C-terminal repetitive region of the protein homologs in _C. auris_. Given that our initial analysis in the case study was based almost exclusively on one strain, B11221 from clade III, it has been on our mind to look into any variation in copy number, domain architecture and other sequence features in other _C. auris_ strains. While there are now 80 (and counting) complete genomes [available](https://www.ncbi.nlm.nih.gov/assembly/organism/498019/latest/), we chose to focus on the four strains that each represent one of the four clades in the Muñoz et al 2018 paper, i.e. B8441 (I), B11220 (II), B11221 (III), B11243 (IV).

A number of findings have already been presented in the Muñoz et al 2021 Genetics paper. Here we first summarize their findings:

1. There are 3-8 members of this protein family in the surveyed _C. auris_ strains. In particular, clade II strains have all lost 5/8 of the members, while the majority of the strains in the other three clades have all 8 (although our reference strain B11221 represents a discrepency between our analysis and theirs, where we only identified 7 and they claimed all 8 are present).
1. All 8 members share the N-terminal Signal Peptide followed by the PF11765 domain, while differing substantially in the sequence makeup of the remaining of the protein. Six of the eight members have intergenic tandem repeats.
1. A genome-wide scan for signatures of accelerated evolution (dN/dS) in each of the four representative strains identified among other genes members of this family, including the _RBR3, HYR3, IFF6_ (gene names based on similarity to _C. albicans_ genes).

The questions we will further pursue in this analysis are:

1. Variability in the tandem repeat copy number.
1. Variability in the TANGO predicted Beta-aggregation sequences.
1. TBD

## Analysis
### 1. Obtain sequences
I performed blastp with the PF11765 domain sequence from XP_028889033 against the combined protein sequence library from five _C. auris_ strains (two clade II strains were used from the Muñoz et al 2018 paper). See `blast/README.md` for details. The resulting fasta file is soft linked to the `input` folder in this analysis.

To make the sequences more easily identifiable, I'd like to standardize the sequence namesas ">STRAIN_ID alternative_name" as in ">B8441_PIS49865.1 B9J08_004892". See `./script/rename_seq.py`, used as `python3 ./script.rename_seq.py ./input/cauris-five-strains-homologs.fasta ./input/cauris-five-strains-renamed.fasta`.

### 2. Sequence feature characterization
1. FungalRV: use the locally installed script to process the input file. See `README.md` in the `FungalRV_adhesin_predictor` folder (linked inside the `script` folder two levels up this folder) for details. The result is symlinked to the `output` folder

    ```bash
    # copy the fasta file to the FungalRV_adhesin_predictor folder under 01-global-analysis/script
    perl ./run_fungalrv_adhesin_predictor.pl cauris-five-strains-renamed.fasta cauris-five-strains-renamed-res.txt y > cauris-five-strains-renamed-frv-log.txt 2>cauris-five-strains-renamed-frv-err.txt
    mv cauris-five-strains-renamed* data-output/
    # finally, copy or link the output file back to the output folder here
    ```

1. FaaPred: the server seems to be down again.
1. PredGPI: results from the [web server](http://gpcr.biocomp.unibo.it/predgpi/)

### 3. Alignment and gene tree
_Goal_

- Determine the gene geneaology of the _C. auris_ sequences.
- Use as the order for plotting sequence traits

_Approach_

1. Add two _D. hansenii_ sequences as determined in previous studies to be the outgroup for the _C. auris_ homologs (XP_002770057.1, XP_462630.1) and make a new fasta file for alignment and gene tree inference.
1. I decided to also add the homologs from _C. haemuloni_ and _C. pseudohaemuloni_, which would help reveal the gene family's evolutionary history within the _Clavispora_ genus.

    ```bash
    bioawk -c fastx '$name ~ /Chaemuloni/{print ">"$name; print $seq}' XP_028889033_homologs_combine.fasta >> cauris-five-strains-for-gene-tree.fasta
    bioawk -c fastx '$name ~ /Cpseudohaemulonis/{print ">"$name; print $seq}' XP_028889033_homologs_combine.fasta >> cauris-five-strains-for-gene-tree.fasta
    ```

    I also added the results associated with these two species to the _C. auris_ results obtained above using `grep` and redirection.

1. Align the sequences, using the script developed previously for the ARGON cluster.
    - Based on RAxML's [user manual](https://cme.h-its.org/exelixis/resource/download/NewManual.pdf), which recommended to leave out the outgroup in the initial tree reconstruction and instead add them later using the [EPA](https://academic.oup.com/sysbio/article/60/3/291/1667010?login=true) pipeline.

    - RAxML detected 12 sequences in the dataset that are identical to other sequences. These are 

### 4. TANGO prediction
- copied the `tango2_3_1` executable from `../../../01-global-adhesin-prediction/output/C_auris/tango-output/`. The exectuable in the `01-global/script` folder doesn't work on ARGON, probably because it was compiled on a different platform (windows?)
- used the `output/tango/format_tango_batch.py` to generate the shell script, and used `qsub -q BH -cwd output/tango/cauris-five-strains-for-tango_tango.sh` to run it on the computing node.
- the resulting txt files were gzipped and commited
- note that I ran the outgroup sequences as well instead of linking them from other places, just for convenience sake. better check that the results are the same.
## Misc notes
