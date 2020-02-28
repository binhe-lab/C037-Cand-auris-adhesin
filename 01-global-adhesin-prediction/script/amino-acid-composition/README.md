---
title: Calculate amino acid composition of predicted adhesins
author: Bin He
date: 2020-02-26
---

# Goal

Based on Lipke 2018 (pmid:29772751), fungal adhesin molecules are characterized by several amino acid composition features, including Cys-rich regions, presence of tandem repeats, dibasic sequences (KK, RR, KR, RK).

# Methods

## 2020-02-27 Update:

Replaced EMBOSS programs with a simple `grep`
The old scripts are now moved as `.old`. The new code executes much faster.

## 2020-02-27 Update 2: 

Switched to Python, as it is more flexible and can output both cysteine and dibasic motifs in the same script.


## Install bioawk

Follow the author's [github repo](https://github.com/lh3/bioawk)

## Install EMBOSS

Use [EMBOSS](http://emboss.sourceforge.net/download/) tools to quantify amino acid compositions.
Installed following the instructions on the website
```bash
$ ./configure --prefix=/Users/bhe2/bin
$ make install
```

## Data for determining the threshold

Copy the Ascomycota adhesin sequences in the Lipke 2018 paper and run the tests on them to decide what criteria was used in that paper to call "Cys-rich", for example.

Instead of ripping the sequences from the pdf, which I found to be problematic, I instead searched and found all the sequences on Uniprot. I believe this is the original source of the sequences, even though the IDs don't always match. I also changed the first two letters of the ID, which was "sp", standing for SwissProt, to the three letter species shorthand, e.g. Calb, Scer. A useful [wiki](https://en.wikipedia.org/wiki/FASTA_format) reference for fasta ID codes.

## Command line tools

| Command | Description | Parameters |
|---------|-------------|------------|
| compseq | amino acid composition | word size = 1 or 2 for Cys or dibasic motif |
| bioawk | parse fasta files | see separate .awk scripts |
| awk | parse and sum frequencies | see separate .awk scripts |

## Main program

```bash
sh RUNME_cysteine_dibasic.sh
```
