---
title: Collect FungalRV predicted adhesin sequences
author:
date:
---

## original analysis, didn't record the person or date
This folder contains predicted adhesins in fasta format, copied from `output/FungalRV` and `output/FaaPred` folders.

The concatenated fasta files are made by 
```bash
cat *faapred*.fasta > all_faapred_adhesins_20200226.fasta
cat *fungalRV*.fasta > all_fungalRV_adhesins_20200319.fasta
```

## update 2020-06-04 [HB]

I added _S. cerevisiae_ proteins with FungalRV scores greater than zero. The script is in `../../script/FungalRV_adhesin_predictor/`. I used the `extract_fasta.py` to extract the fasta sequences and combined them with the other species' sequences using the following command inside the `../../output/FungalRV/` folder.

```bash
find . -iname "*_filtered.fasta" -exec cat {} >> all_fungalRV_predicted_adhesins.fasta \;
```

## update 2020-07-16 [HB/RS]
Added `all_predicted_adhesins_w_other.fasta`, which is a compilation of FungalRV predicted adhesins for an expanded list of species that Rachel has been working on. The goal is to extend most of our global analyses to this larger set of sequences.
