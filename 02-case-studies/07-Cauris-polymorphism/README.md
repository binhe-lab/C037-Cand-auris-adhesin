<!--ts-->
   * [Introduction](#introduction)
   * [Analysis](#analysis)
      * [1. Obtain sequences](#1-obtain-sequences)
      * [2. Sequence feature characterization](#2-sequence-feature-characterization)
      * [3. Alignment and gene tree](#3-alignment-and-gene-tree)
      * [4. TANGO prediction](#4-tango-prediction)
      * [5. Confirm C-terminal repeat number variation with additional strains' genomes](#5-confirm-c-terminal-repeat-number-variation-with-additional-strains-genomes)
         * [tblastn to identify orthologs of XP_028889033 in additional <em>C. auris</em> genomes](#tblastn-to-identify-orthologs-of-xp_028889033-in-additional-c-auris-genomes)
         * [Build fasta sequence from the blast results and align](#build-fasta-sequence-from-the-blast-results-and-align)
      * [6. Identify tandem repeat](#6-identify-tandem-repeat)

<!-- Added by: bhe2, at: Thu May 20 17:24:53 CDT 2021 -->

<!--te-->
# Introduction
This analysis is inspired by a discussion at the poster session during the 2021 Candida and Candidiasis meeting. One of the questions that come up was whethere there are intra-species variation especially in the C-terminal repetitive region of the protein homologs in _C. auris_. Given that our initial analysis in the case study was based almost exclusively on one strain, B11221 from clade III, it has been on our mind to look into any variation in copy number, domain architecture and other sequence features in other _C. auris_ strains. While there are now 80 (and counting) complete genomes [available](https://www.ncbi.nlm.nih.gov/assembly/organism/498019/latest/), we chose to focus on the four strains that each represent one of the four clades in the Muñoz et al 2018 paper, i.e. B8441 (I), B11220 (II), B11221 (III), B11243 (IV).

A number of findings have already been presented in the Muñoz et al 2021 Genetics paper. Here we first summarize their findings:

1. There are 3-8 members of this protein family in the surveyed _C. auris_ strains. In particular, clade II strains have all lost 5/8 of the members, while the majority of the strains in the other three clades have all 8 (although our reference strain B11221 represents a discrepency between our analysis and theirs, where we only identified 7 and they claimed all 8 are present).
1. All 8 members share the N-terminal Signal Peptide followed by the PF11765 domain, while differing substantially in the sequence makeup of the remaining of the protein. Six of the eight members have intergenic tandem repeats.
1. A genome-wide scan for signatures of accelerated evolution (dN/dS) in each of the four representative strains identified among other genes members of this family, including the _RBR3, HYR3, IFF6_ (gene names based on similarity to _C. albicans_ genes).

The questions we will further pursue in this analysis are:

1. Variability in the tandem repeat copy number.
1. Variability in the TANGO predicted Beta-aggregation sequences.
1. TBD

# Analysis
## 1. Obtain sequences
I performed blastp with the PF11765 domain sequence from XP_028889033 against the combined protein sequence library from five _C. auris_ strains (two clade II strains were used from the Muñoz et al 2018 paper). See `blast/README.md` for details. The resulting fasta file is soft linked to the `input` folder in this analysis.

To make the sequences more easily identifiable, I'd like to standardize the sequence namesas ">STRAIN_ID alternative_name" as in ">B8441_PIS49865.1 B9J08_004892". See `./script/rename_seq.py`, used as `python3 ./script.rename_seq.py ./input/cauris-five-strains-homologs.fasta ./input/cauris-five-strains-renamed.fasta`.

## 2. Sequence feature characterization
1. FungalRV: use the locally installed script to process the input file. See `README.md` in the `FungalRV_adhesin_predictor` folder (linked inside the `script` folder two levels up this folder) for details. The result is symlinked to the `output` folder

    ```bash
    # copy the fasta file to the FungalRV_adhesin_predictor folder under 01-global-analysis/script
    perl ./run_fungalrv_adhesin_predictor.pl cauris-five-strains-renamed.fasta cauris-five-strains-renamed-res.txt y > cauris-five-strains-renamed-frv-log.txt 2>cauris-five-strains-renamed-frv-err.txt
    mv cauris-five-strains-renamed* data-output/
    # finally, copy or link the output file back to the output folder here
    ```

1. FaaPred: the server seems to be down again.
1. PredGPI: results from the [web server](http://gpcr.biocomp.unibo.it/predgpi/)

## 3. Alignment and gene tree
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

## 4. TANGO prediction
- copied the `tango2_3_1` executable from `../../../01-global-adhesin-prediction/output/C_auris/tango-output/`. The exectuable in the `01-global/script` folder doesn't work on ARGON, probably because it was compiled on a different platform (windows?)
- used the `output/tango/format_tango_batch.py` to generate the shell script, and used `qsub -q BH -cwd output/tango/cauris-five-strains-for-tango_tango.sh` to run it on the computing node.
- the resulting txt files were gzipped and commited
- note that I ran the outgroup sequences as well instead of linking them from other places, just for convenience sake. better check that the results are the same.

## 5. Confirm C-terminal repeat number variation with additional strains' genomes

_Motivation_

During my presentation of the _C. auris_ polymorphism results, Rachel raised the question over the observed variation in the tandem repeat copy number in the XP028889033 group, where the clade I strain (B8441) homolog appears to have missed two complete repeat units (44 a.a. each). Her question is whether this difference is real or due to sequencing or assembly errors. 

_Approach_

To confirm the difference, my approach is to obtain more homologs in Clade I as well as Clade III and IV (Muñoz _et al._ 2021, PMID: 33769487) and align them.

### `tblastn` to identify orthologs of XP_028889033 in additional _C. auris_ genomes
To do so, I first downloaded these genomes (see notes in `./input/genome-seq/README.md`). Then I built the blast database.

Build the blast database:

```bash
cd input/genome-seq/
cat clade-iii/GCA*.fna.gz > cauris-no-clade-ii.fna.gz
cat clade-i-iv/GCA*.fna.gz >> cauris-no-clade-ii.fna.gz
cd ../
mkdir blastdb
gunzip -c ./genome-seq/cauris-no-clade-ii.fna.gz | makeblastdb -in - -parse_seqids -dbtype nucl -title cauris-no-clade-ii -out ./blastdb/cauris-no-clade-ii
```

The following commands are now in the `script/blast-XXX.sh`.

```bash
tblastn -db ./blastdb/cauris-no-clade-ii -query XP_028889033-query.fasta -db_gencode 12 -evalue 1e-160 -seg "no" -max_hsps 2 -num_threads 4 -outfmt 11 -out ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.asn
# -db_gencode 12: yeast alternative genetic code table when we use the tblastn program
# -evalue 1e-160: cutoff to limit the hits (mainly) to the orthologs for XP_028889033
# -seg "no"     : turn off query masking
# -max_hsps 2   : show only top 2 high scoring pair per subject sequence
#                 the alignment is split into two segments, one covering the PF11765 and the other the stalk
#                 but the middle S-rich region is probably masked at some point, so the results are discontinuous
# -num_threads 4: use 4 threads
# -outfmt 11    : BLAST achive, can be later converted to other formats
blast_formatter -archive ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.asn -outfmt 0 -out ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.aln
blast_formatter -archive ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.asn -outfmt 3 -out ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.flat
blast_formatter -archive ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.asn -outfmt "7 sseqid qcovs qstart qend slen sstart send qcovshsp pident mismatch evalue" -out ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.txt
blast_formatter -archive ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.asn -outfmt "6 sseqid sseq" -out ./cauris-no-clade-ii-XP_028889033-homologs.tblastn.fasta
```

_Results_

Clade I: B8441, B11205, B13916
Clade III: B11221, B12037, B12631, B17721.
Clade IV: B11245, B12342

**Full length protein query**

| Strain | Clade | Chr | sseqid     | s.start | s.end  | q.start | q.end | qcovs | pident | gaps |
|--------|-------|---- |------------|---------|------- | --------| ----- | ------| ------ |------|
| B11221 | III   | 6   | scaffold06 | 23449   | 32604  | 1       | 3052  | 100   | 100    | 0    |
| B17721 | III   | 6   | CP060358.1 | 925910  | 916755 | 1       | 3052  | 100   | 100    | 0    |
|*B12631 | III   | 6   | CP060365.1 | 334     | 1938   | 2518    | 3052  | 18    | 98.9   | 0    |
|*B12037 | III   | 7   | CP060373.1 | 24671   | 33898  | 1       | 3052  | 100   | 99.2   | 24   |
| B12037 | III   | 6   | CP060372.1 | 969691  | 966593 | 1648    | 2678  | 37    | 71.8   | 56   |
| B12342 | IV    | 6   | CP060351.1 | 25433   | 34462  | 1       | 3052  | 100   | 95.8   | 42   |
| B11245 | IV    | 6   | CP043447.1 | 941526  | 935932 | 1188    | 3052  | 82    | 97.4   | 0    |
| B11245 | IV    | 6   | CP043447.1 | 941487  | 936418 | 541     | 2211  | 82    | 62.9   | 0    |
| B11205 | I     | 6   | CP060344.1 | 26478   | 33797  | 613     | 3052  | 83    | 86.6   | 0    |
| B13916 | I     | 6   | CP060379.1 | 17166   | 24485  | 613     | 3052  | 83    | 86.6   | 0    |

_Discussion_

- I couldn't retrieve the entire homologous region from each strain.
    - Not surprisingly, the search identified the query protein itself from B11221
    - B17721 seems to be identical to B11221 in this particular protein, although the genomic location appears to be at the other end of the chromosome -- is this real or could it be artificial?
    - In B12631 only the C-terminal part of the protein is identified and its chromosomal location suggests to me that the chromosome is not completely assembled.
    - In B12037, the entire homologous region was identified, but on a different chromosome (7) while a hit on the same chromosome (6) is partial and has higher level of divergence. Could this also be due to assembly issues?
    - In one of the two Clade IV strains, the entire homologous region can be identified, while in the other one only a portion is recovered. In the latter, two BLAST hits are present that largely overlap.
    - In the two Clade I strains, only the C-terminal portion can be identified.

**NTD query**

The search last time with the full length XP_028889033 weirdly recovered only the C-terminal stalk in many strains, while I had expected the the entire length of the ortholog to be identified. To confirm that I can indeed recover the NTD, I repeated the search (`script/blast-NTD.sh`) with just the NTD of the query. It turns out that `blast` has a neat option named `query_loc start-end` that allows me to do so easily.

Note: I added to the table above, but only included a hit if the original full length blast didn't recover the NTD.

| Query | Strain | Clade | Chr | sseqid     | q.start | q.end | s.start | s.end  | qcovs | pident |
|-------|--------|-------|-----|------------|---------| ----- |---------|------- | ------| ------ |
| full  | B11221 | III   | 6   | scaffold06 | 1       | 3052  | 23449   | 32604  | 100   | 100    |
| full  | B17721 | III   | 6   | CP060358.1 | 1       | 3052  | 925910  | 916755 | 100   | 100    |
| full  |*B12631 | III   | 6   | CP060365.1 | 2518    | 3052  | 334     | 1938   | 18    | 98.9   |
| full  |*B12037 | III   | 7   | CP060373.1 | 1       | 3052  | 24671   | 33898  | 100   | 99.2   |
| full  | B12037 | III   | 6   | CP060372.1 | 1648    | 2678  | 969691  | 966593 | 37    | 71.8   |
| full  | B12342 | IV    | 6   | CP060351.1 | 1       | 3052  | 25433   | 34462  | 100   | 95.8   |
| full  | B11245 | IV    | 6   | CP043447.1 | 12      | 327   | 944923  | 943976 | 10    | 99.4   |
| full  | B11245 | IV    | 6   | CP043447.1 | 541     | 2211  | 941487  | 936418 | 82    | 62.9   |
| full  | B11245 | IV    | 6   | CP043447.1 | 1188    | 3052  | 941526  | 935932 | 82    | 97.4   |
| NTD   | B11205 | I     | 6   | CP060344.1 | 12      | 327   | 24993   | 25940  | 10    | 99.7   |
| full  | B11205 | I     | 6   | CP060344.1 | 613     | 3052  | 26478   | 33797  | 83    | 86.6   |
| NTD   | B13916 | I     | 6   | CP060379.1 | 12      | 327   | 15681   | 16628  | 10    | 99.7   |
| full  | B13916 | I     | 6   | CP060379.1 | 613     | 3052  | 17166   | 24485  | 83    | 86.6   |

_Discussion_

- Now only B12631 is missing the NTD and it seems most likely that chromosome 6 in this strain is incomplete
- B12037 still has the best match on chromosome 7.

### Build fasta sequence from the blast results and align
Using the `.aln` output from the `blast_formatter`, I can easily build a fasta file (the other way is to copy the chromosomal coordinates and use `seqtk faidx` to extract the regions. I then added the three sequences from the original _C. auris_ polymorphism analysis (based on the five strains in Muñoz _et al._ 2018). I subjected the sequences to ClustalO alignment with 5 iterations (in Jalview), and saved the output in `output/blast-out`.

_Results_

![Deletion 1](output/figure/20210430-XP_028889033-extra-strains-alignment-tango-del1.png)

![Deletion 2](output/figure/20210430-XP_028889033-extra-strains-alignment-tango-del2.png)

_Conclusion_

The two deletion of 44 amino acid each in the clade I strain B8441 are also present in the other two clade I strains. Therefore I'm confident that these two length polymorphisms are real. No additional variation in the C-terminal Thr-rich repeats were discovered with the additional sequences.

## 6. Identify tandem repeat

_Motivation_

Tandem repeats (TR) are both a known sequence feature of characterized fungal adhesins, and could also serve to highlight the differences in the non-NTD portion of the 8 HIL family members in _C. auris_ and in its relatives.

_Approach_

1. Reorder fasta sequences according to the gene tree order. This will allow the block scheme generated by XSTREAM to fit with the gene tree. (turns out this wouldn't work because XSTREAM doesn't use the input sequence order to sort the schematics in the block PNG)

    ```bash
    python3 script/extract_fasta.py input/cauris-five-strains-for-gene-tree.fasta input/cauris-reorder-by-gene-tree.faa
    ```

1. Use [XSTREAM](https://amnewmanlab.stanford.edu/xstream) for TR identification. I created a script in the `script` folder to automate this part. See there for explanation.

1. After the reports are generated, I then made a copy of the excel spreadsheet (actually just a tsv file) and manually added a column named "class", whose value is taken from the first column (number id) in the "html_1" file. This is to combine TRs in the same family and assign them the same ID in order for latter plotting.

1. The goal is to create a plot that is similar to the PNG files generated by XSTREAM. The reason I didn't use that PNG directly is because 1) they were normalized by length while I'd like to keep the cartoon proportional to the length of each sequence and 2) the order of the sequences in the block PNG cannot be adjusted by the user through manipulating the order of the sequences in the input file. The code and output can be viewed under the current folder (Rmd and html output)
