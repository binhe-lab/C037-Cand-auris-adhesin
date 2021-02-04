This folder describes the analysis on the full proteomes of four *C. auris* strains: B8441, B11220, B11221, and B11245

The analysis is done in the [C_auris.rmd](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/C_auris.rmd) file.

# Proteomes

The proteomes can be retreived from the NCBI assembly ftp sites for [B8441](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/759/435/GCA_002759435.2_Cand_auris_B8441_V2/GCA_002759435.2_Cand_auris_B8441_V2_protein.faa.gz), [B11220](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/013/715/GCA_003013715.2_ASM301371v2/GCA_003013715.2_ASM301371v2_protein.faa.gz), [B11221](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/775/015/GCF_002775015.1_Cand_auris_B11221_V1/GCF_002775015.1_Cand_auris_B11221_V1_protein.faa.gz), and [B11245](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/008/275/145/GCA_008275145.1_ASM827514v1/GCA_008275145.1_ASM827514v1_protein.faa.gz). Strains B11243 and B11245 have identical proteomes. B11245 was chosen for this analysis because it is assembled at the chomosome level.  The file C_auris.rmd documents the proteome retrieval and [fasta file](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/Caurisfasta.txt) writing process. The file contains 21772 proteins.

# Sequence Length

The number of amino acids in each protein is calculated in the rmd file for inclusion in the fasta table.

# PredGPI for GPI anchor prediction

Following Bin's method documented [here](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/02-case-studies/output/homolog-properties/2020-10-31), I used the website tool to predict GPI anchors. Only header lines were retained in the uploaded [output](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/PredGPIResults.txt). GPI anchors are predicted when the false positive rate is less than 0.01, matching Bin's code [here](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/02-case-studies/output/homolog-properties/2020-10-31/homologs-properties.Rmd) and including the highly probable, probable, and lowly probable categories by the tool developers. Values are summarized as TRUE or FALSE in the seqInfo table by Bin's [code](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/02-case-studies/output/homolog-properties/2020-10-31/homologs-properties.Rmd).

# hmmscan for pfam domain identification

Using HmmerWeb version 2.41.1, I submitted all proteins for hmmscan to search for domains against the pfam database. The results came in the body of an email, so I collected them, ensured that all jobs submitted had results, and compiled just the results into an [output file](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/hmmer_results.txt). The .rmd file summarizes the non-overlapping domains found in each protein. In cases of overlap, the highest-scoring domain wins (using the outcompeted column in the data) and adds this information to the seqInfo table.

# SignalP for signal peptide prediction

Following Bin's method documented [here](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/02-case-studies/output/homolog-properties/2020-10-31), I used the SignalP 5.0 server to predict signal peptides. I compiled the resulting .gff3 files into one [output file](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/SignalP.txt). Values are summarized as TRUE or FALSE in the seqInfo table by Bin's [code](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/02-case-studies/output/homolog-properties/2020-10-31/homologs-properties.Rmd).

# TANGO for aggregation sequence prediction

I created a [.bat file](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/tango_in.bat) to run TANGO on the proteins. Because each proteins outputs a single text file, I used gzip to compress all outputs and placed them [here](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/01-global-adhesin-prediction/output/C_auris/tango-output).

**update [HB] 2021-01-30**

Rachel encountered a number of calculation errors when running tango on her machine. Bin took the bat sequence and modified it so it can be run on his machine using `tango2_3_1` compiled for linux/Mac OS. The 37 example ones ran without a problem, and upon further examination, it seems the other result files that Rachel didn't mention also contain the "-1.#IO" error in the Helix column of the output, and importantly, the Aggregation column values were also affected. So Bin reran all the sequences on ARGON using and put the output in the separate `tango-output-hb` folder.

**for analyis**

The results have already been parsed and are available in the [tango_results_df.txt](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/tango_results_df.txt) file that you can download if you don't want to download and parse all of the files locally, which takes several hours. Comments in the [C_auris.rmd](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/C_auris.rmd) file instruct you on how to use it.

## freak for S/T frequency calculations

Using Bin's [method](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/02-case-studies/output/homolog-properties), I calculated the sliding window frequency of S & T, S, and T. Raw outputs are as .txt.gz files and formatted outputs are as .out.gz files [here](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/01-global-adhesin-prediction/output/C_auris/freak). The maximum frequencies for S/T, S, and T are summarized in the seqInfo table in the .rmd.

## Results summary table

A results summary table can be generated in [C_auris.rmd](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/C_auris.rmd) file or is available in [seqInfo_table.txt](https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/output/C_auris/seqInfo_table.txt). Procedures are discussed in the rmd.
