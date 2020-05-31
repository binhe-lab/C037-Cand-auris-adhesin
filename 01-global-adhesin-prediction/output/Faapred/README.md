# Goal
Subject FungalRV predicted adhesin genes to a second level of scrutinization, in order to reduce false positives, but could increase false negatives.

# Notes
## February 9, 2020 [LFS] Predicted adhesins with Faapred
1.Divided positive hits from FungalRV into files with 25 or less sequences (requirement of Faapred)
2.Submit files to [Faapred](http://bioinfo.icgeb.res.in/faap/query.html) using default parameters, ACHM model with a threshold of -0.8 PMID: 20300572
3.Output saved in output/Faapred folder

## February 28, 2020 [LFS] List all predicted gene names

```bash
find . -iname "*.fasta" -exec grep "^>" {} \; > all-faapred-seq-names-20200228.txt
# then used vim to remove the preceding ">"
```
