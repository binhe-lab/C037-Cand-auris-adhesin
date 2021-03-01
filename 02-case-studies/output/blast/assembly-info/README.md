---
author: Bin He
date: 2020-10-24
---

stores assembly information for extracting chromosomal locations (or in scaffolds/contigs). the bulk of the files were automatically downloaded (see `blast.Rmd` section on getting genome annotation). one exception is _K. lactic_, whose genome assembly feature table and other files were manually downloaded using the following commands (2021-02-27):

```bash
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/515/GCF_000002515.2_ASM251v1/GCF_000002515.2_ASM251v1_feature_table.txt.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/515/GCF_000002515.2_ASM251v1/GCF_000002515.2_ASM251v1_assembly_report.txt
```
