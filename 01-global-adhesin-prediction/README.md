# Questions

Are there other genes in the _C. auris_ genome that share the sequence properties of the Hil family? If so, they could be potential adhesins.

# Background

We originally wanted to compare the adhesin genes in diverse species of yeasts to determine if the number, sequence features and other properties are similar or distinct among the adhesin genes in different species, whether they were ancestral and inherited, or were many of them species specific, suggesting that they evolved de novo. The attempt is documented in the `archive` folder. The basis of that analysis was the predicted adhesins in a number of yeast species. However, we realized that the fungal adhesin predictors are far from being able to accurately predict the adhesins and not including false positives. Analysis built on top of the prediction results would then be highly unreliable. We thus focused most of our energy on the case study of the Hyr/Iff-like (Hil) family proteins. After detailed analyses of that family, we started to wonder if **there are more proteins that are like the Hil proteins** in the _C. auris_ proteome, hence the current analysis.

# Notes

## 2021-07-09 PIS58185.1

While analyzing the TANGO hit sequences in the _C. auris_ proteome, it came to our attention that while most of the strong TANGO hits are GVVIVTT-like and the vast majority of them are in the Hil family proteins, one GVVIVTT-like sequence, "GVVIVT", is unique in that there are a total of 82 instances found in the four _C. auris_ proteomes and yet none of them are within the Hil family homologs. When we looked into what proteins have it, we have the following:

| pID            | gID          | Length | Chromosome | Strain | Clade |
| -------------- | ------------ | ------ | ---------- | ------ | ----- |
| PIS58185.1     | B9J08_000675 | 2608   | Chr2       | B8441  | I     |
| QEO22553.1     | NA           | 970    | Chr3       | B11220 | II    |
| XP_028893057.1 | CJI97_000676 | 1385   | Chr2       | B11221 | III   |
| QEL60526.1     | CJJ09_002636 | 1600   | Chr2       | B11245 | IV    |

From this table our guess is that except for QEO22553.1, the others are probably orthologs. We then used PIS58185.1 as query and searched against the non-redundant proteome database with blastsp. The result is stored in `output/PIS58185/20210709-PIS58185-blastp-in-cauris.txt`. Below is a graphic annotation of the search result:
![blastp search for PIS58185 in _C. auris_](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/20210709-PIS58185-blastp-in-cauris.png)

This is rather interesting: Hil1-4 are the longer than 1000 amino acids and have regularly spaced GVVIVTT sequences, and they are the ones that showed up in this search, suggesting that the C-terminal sequence of PIS58185 bear significant similarity with Hil1-4. (Three additional sequences also showed up. Two of them, PSK75098 and QEO22553, belong to B11243 and B11245, both of which are from clade IV. They are both shorter than the rest but contained the GVVIVT sequences. The third one, QEL63124, actually is the **only** nonHIL protein that contains the GVVIVTT sequence!)

We further asked how this new protein relates to Hil1-4. We used Hil1 as the representative and aligned PIS58185 and XP_028889033.

![PIS58185 aligned to XP_028889033](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/PIS58185-XP_028889033-alignment.png)

The result revealed that PIS58185 has significant similarity with XP_028889033 in the non-NTD portion. They even share the same tandem repeat unit, but with the key distinction that we identified above: one has GVVIVTT while the other has GVVIVT. Its similarity to Hil2,3 and 4 are less significant. But a separate [analysis](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/02-case-studies/07-Cauris-polymorphism/output/dot-plot) showed that the tandem repeat unit, which contains the GVVIVTT motif, likely had a common origin during evolution among Hil1-4 and Hil7-8, which, after subsequent evolution, now contained different copies and also diverged in the repeat unit. Combined with the results above, we hypothesize that the C-terminal tandem repeats in PIS58185 has the same evolutionary origin as those in the Hil family. It's not possible to determine the exact evolutionary process without further analyses of the tandem repeats themselves though.

Coming back to QEL63124.1: a closer look revealed that this protein is nearly identical to the central and C-terminal domains of Hil1, matching the latter from residues 800ish and on. Since this protein only appears in the clade IV species, I suspect it results from a recent partial duplication. It's unclear whether this polymorphic gene is functional or not.
