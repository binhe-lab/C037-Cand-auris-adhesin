---
title: FungalRV prediction tool
author: Bin He
date: 2020-02-10
---

# Scripts

| Item | Description | Source | Date |
| ---- | ----------- | ------ | ---- |
| batch-fungalrv-predict.sh | shell script to run the FungalRV prediction algorithm on a list of proteome files | HB, custom | 2020-02-28 |
| run_fungalrv_adhesin_predictor.pl | wrapper script to run the FungalRV prediction algorithm | http://fungalrv.igib.res.in/download.html | 2020-02-09 |
| extract_fasta.sh | shell script to extract fasta sequences based on a list of IDs | HB, custom | 2020-02-04 |
| extract_fasta.py | python script to extract fasta sequences based on a list of IDs | HB, custom | 2020-05-30 |
| process-fungalrv-output.sh | shell script to extract the protein ID and fungalRV score | HB, custom | 2020-06-23 |
# Notes
## 2020-02-10 Compiled and tested FungalRV code
Used the following command to compile the c files on my Ubuntu. Should be similar on other machines, too. If the binaries don't work on other systems, follow my example to compile the source c code.

```bash
# I assume you are in the FungalRV script folder, where the c source files are
for f in *.c;do gcc $f -o ./bin/${f/.c/}; done
```

Note that `FungalRV_adhesin_predictor/calc_hdr_comp.c` failed to compile.

## 2020-02-19 Solved error in compiling one of the FungalRV code
Error:
> undefined reference to `pow'
> error: ld returned 1 exit status

This [link](https://stackoverflow.com/questions/12824134/undefined-reference-to-pow-in-c-despite-including-math-h) solved the problem.

`gcc calc_hdr_comp.c -o bin/calc_hdr_comp -lm`

## 2020-02-28 Downloaded SVM light and the standalone is now functional
Download the Mac OS new verison from the author's [website](http://download.joachims.org/svm_light/current/svm_light_osx.8.4_i7.tar.gz), untarred the file and just moved the `svm_classify` in the current folder. Note that if someone wants to run the program, s/he will likely need to download the version of `svm_classify` suitable for the OS, and may need to recompile the C source files.

Wrote a wrapper script `batch-fungalrv-predict.sh` to process all genome files. Two genomes threw a lot of errors, one of which is _C. albicans_. I unzipped the protein file and uploaded onto the FungalRV web app, and processed there. Among 6030 sequences, 5971 were successfully processed, with 231 above the threshold of 0. I downloaded the results and replaced the script output. The output files were moved to `output/FungalRV/local-result-HB/`, while the log and error files were not committed to the repository.
## 2020-05-29 Run FungalRV on _S. cerevisiae_ R64 proteome
Run locally and result moved to the output folder

## 2020-05-30 Rewrote the fasta extraction script in Python and run it to get the _S. cerevisiae_ sequences
```bash
$ python3 extract_fasta_fungalRV.py ../../output/FungalRV/local-result-HB/S_cerevisiae_GCF_000146045.2_R64_protein.txt S_cerevisiae_GCF_000146045.2_R64_protein.faa.gz
$ mv S_cerevisiae_GCF_000146045.2_R64_protein_filtered.faa ../../output/FungalRV/local-result-HB/
```
## 2020-06-23 Run FungalRV locally on the new _C. glabrata_ proteins
Copied the `batch-fungalrv-predict.sh` and modified it to be used for a single genome using a command line argument
```bash
$ sh single-species-fungalrv.sh C_glabrata_CBS138_new_genome_release_20200224_protein.faa.gz
$ sh process-fungalrv-output.sh C_glabrata_CBS138_new_genome_release_20200224_protein.txt C_glabrata CBS138new > C_glabrata_CBS138_new_fungalRV.txt
$ mv C_glabrata_GCA_010111755.1_ASM1011175v1_protein.txt ../../output/FungalRV/local-result-HB/
# cd into the output folder
$ cd ../../output/FungalRV/local-result-HB
# and edited the combine-result.sh to include the new result
$ sh combine-result.sh > all-fungalrv-results-20200623.txt
```
Checking the results in R shows reasonable numbers of predicted adhesins
```r
> library(tidyverse)
> dat <- read_tsv("all-fungalrv-results-20200623.txt", comment = "#")
> dat %>% 
    filter(Score > 0) %>%g
     roup_by(Strain) %>% 
     summarize(">.511" = sum(Score > 0.511), n = n())

# A tibble: 7 x 3
#   Strain    `>.511`     n
#   <chr>       <int> <int>
# 1 B11220         36   100
# 2 B11221         46   113
# 3 B8441          47   112
# 4 CBS138         62   142
# 5 CBS138new      82   162
# 6 S288C          58   179
# 7 SC5314        143   290
```
## 2020-07-25 Complile SVM light
After upgrading to MacOS Catalina, the previously downloaded binary version of `svm_classify` no longer works. Instead, I downloaded the source file and compiled it locally. Things are fine now. Source file location: http://download.joachims.org/svm_light/current/svm_light.tar.gz 
## 2021-04-05 reorganize files and run fungalRV locally for Cauris homologs
I reorganized files in this folder so all the input and output files are now in the `data-output` folder, while the original fungalRV scripts and my custom scripts are in the level-1 folder. I then ran the script to process the newly extracted Cauris-homologs-fasta.

```bash
$ cd data-output
$ perl ../run_fungalrv_adhesin_predictor.pl cauris-five-strains-homologs.fasta cauris-five-strains-homologs-frv-res.txt y > cauris-five-strains-homologs-frv-log.txt 2>cauris-five-strains-homologs-frv-err.txt
$ grep "^>" cauris-five-strains-homologs-frv-res.txt| grep -v "QEO" | \
	awk -F "\t" 'BEGIN{OFS="\t"} {split($0,name," "); gsub(">","",name[1]); split(name[4],strain,"_");\
		print "Cauris",strain[1],name[1],$2}' > cauris-five-strains-homologs-frv-res-formatted.txt
$ mv cauris-five-strains* data-output/
```
## 2022-06-17 Recompile C source files
I couldn't find the previously compiled C programs (they were stored in a `bin` directory, which seems to have been lost). To recompile them on the new MacOS v12.4, both `gcc` and `clang` would complain about implicit type specifications in the source code. Based on the error message, I figured out the solution: adding a line `#include <ctype.h>` to the top of each `.c` file, and do the following
```bash
for f in *.c;do clang $f -o bin-mac/${f/.c/}; done
```

It turns out that I don't need to append the `-lm` flag for one of the source files to compile anymore.
