---
title: Use BLAST to identify homologs for XP_028889033.1
author: Bin He
date: 2020-07-01
---

# Goal

- Repeat the blast step to clean up the homologs list.
    some species were missing while others, like _C. albicans_, had more than one strain represented in Lindsey's version.


# Content

| File | Description | Source | User/Date |
| -----|-------------|--------|---------- |
| XP_028889033_homologs_fungidb.fasta | New blast results, 95 sequences | fungidb, see notes below | HB/2020 |
| XP_028889033_homologs_fungidb_table.tsv | Accompanying meta data for the file above | fungidb | HB/2020 |
| XP_028889033_homologs_fungidb_use.fasta | filtered list with length > 500, 82 sequences | fungidb, see notes below | HB/2020 |
| XP_028889033_fungidb-refprot-blast.txt | fungiDB hits blasted against the refseq_protein database to identify matching sequences | NCBI BLAST | HB/2020 |
| XP_028889033_homologs_refprot.fasta | XP_028889033 blast against refseq_protein database | NCBI refseq_protein | HB/2020 |
| XP_028889033_homologs_refprot_tab.csv | Accompanying "description" table for the file above | NCBI BLAST | HB/2020 |
| 20200704-ncbi-blastp-XP_028889033-taxonmy-distribution.png | screenshot of the taxonomy distribution of the above blast result | NCBI blast | HB/2020 |

# Notes
## 2020-07-01 [HB] Repeat BLAST to identify XP_028889033 homologs
### FungiDB
Used the beta version of the new site on 2020-07-01

- Used first 560 aa of XP_028889033 as query, e-value cutoff set to 1e-5, low complexity on, and limit the organisms to the CUG clade, _S. cerevisiae_, _C. glabrata_ and _S. pombe_
- Downloaded 97 sequences along with a table with meta information.
- After examining the meta data, I noticed that some sequences are much shorter than others. I then plotted protein length as a function of e-value, both in log scales, and it became apparent that those sequences below 500 amino acids are the ones with the lowest e-values. I thus removed them by printing a list of gene IDs, and used the `extract_fasta.py` program to output the filtered list.
    ![length-vs-e-value](20200701-XP_028889033-homologs-e-value-by-length.png)

### Retrieve ref_protein ID for FungiDB hits
```bash
$ blastp -db refseq_protein -query XP_028889033_homologs_fungidb_use.fasta -outfmt "6 qseqid sseqid qlen slen pident mismatch score bitscore evalue" -max_target_seqs 1 -remote -out XP_028889033_fungidb_refprot_id.txt
```
However, for some reason this command didn't work (2020-07-04: I think it actually just takes a long time. Instead of returning an ID for later retrieval of the results, it appears that the user actually have to wait until the search finishes). Instead, I submitted the XP_028889033_homologs_fungidb_use.fasta to NCBI blastp with the same parameters. The result is registered with RID: G2HK3CWK014. I then downloaded the results with a local command
```bash
$ blast_formatter -rid G2HK3CWK014 -out fungidb_blast_refseq_protein.txt -outfmt "6 qseqid sseqid qlen slen pident mismatch score bitscore evalue" -max_target_seqs 1
$ cut -f1 fungidb_blast_refseq_protein.txt | sort | uniq | wc -l
# 70, correct
```


### NCBI blast
`blastp` with the first 560 aa of XP_028889033, e-value cutoff 1e-5, low complexity sequences masked (there is now an option to only mask the low complexity region when generating the seed, but leave them be during the extension).
- I also tried `Delta-blastp`, which first searches against the conserved domain database and then gather sequences with that domain. This resulted in way too many hits. Didn't pursue further.
- For the `blastp` results, I further required the query coverage to be greater than 50%, which yielded 144 sequences. This cutoff was chosen subjectively as sequences with lower than 50% coverage appear uninteresting (in species that are not what I'm interested in).
- I further excluded 6 species from consideration. These are "Metschnikowia bicuspidata var. bicuspidata NRRL YB-4993 (taxid:869754), Debaryomyces fabryi (taxid:58627), Suhomyces tanzawaensis NRRL Y-17324 (taxid:984487), Candida orthopsilosis Co 90-125 (taxid:1136231), Kazachstania (taxid:71245), Naumovozyma dairenensis CBS 421 (taxid:1071378), Meyerozyma guilliermondii (taxid:4929), Yamadazyma tenuis ATCC 10573 (taxid:590646)"
- The resulting taxonomy is shown ![here](./20200704-ncbi-blastp-XP_028889033-taxonmy-distribution.png)

### Merge the two datasets
1. To merge the two datasets, I decide to blast the fungidb reduced set (a.a. length > 500) to the ref_protein dataset. To do so, I used the following commands
    ```bash
    $ mkdir blastdb; makeblastdb -in XP_028889033_homologs_refprot.fasta -parse_seqids -dbtype prot -title XP_028889033_refprot -out blastdb/XP_028889033_refprot
    $ blastp -db ./blastdb/XP_028889033_refprot -query XP_028889033_homologs_fungidb_use.fasta -outfmt "6 qseqid sseqid qlen slen pident mismatch score bitscore evalue" -max_target_seqs 1 -num_threads 4 -out XP_028889033_fungidb-refprot-blast.txt
    ```
    Explanation
    - -outfmt 6: tabular output, no comments
    - -max_target_seqs 1: only output one (best-scoring) match per sequence
    - -num_threads 4: use 4 cpus to perform the search
