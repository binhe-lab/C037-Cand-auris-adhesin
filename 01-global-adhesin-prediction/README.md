# Questions

Are there other genes in the _C. auris_ genome that share the sequence properties of the Hil family? If so, they could be potential adhesins.

# Background

We originally wanted to compare the adhesin genes in diverse species of yeasts to determine if the number, sequence features and other properties are similar or distinct among the adhesin genes in different species, whether they were ancestral and inherited, or were many of them species specific, suggesting that they evolved de novo. The attempt is documented in the `archive` folder. The basis of that analysis was the predicted adhesins in a number of yeast species. However, we realized that the fungal adhesin predictors are far from being able to accurately predict the adhesins and not including false positives. Analysis built on top of the prediction results would then be highly unreliable. We thus focused most of our energy on the case study of the Hyr/Iff-like (Hil) family proteins. After detailed analyses of that family, we started to wonder if **there are more proteins that are like the Hil proteins** in the _C. auris_ proteome, hence the current analysis.

# Notes

## 2021-07-09 PIS58185.1

While analyzing the TANGO hit sequences in the _C. auris_ proteome, it came to our attention that while most of the strong TANGO hits are GVVIVTT-like and the vast majority of them are in the Hil family proteins, there are two notable exceptions: first, one protein, QEL63124 from the clade IV strain B11245 (another clade IV strain B11243 has it as well) has all the G[VI]{4}TT sequences outside of the Hil family; second, a GVVIVTT-like sequence, "GVVIVT", occurs for a total of 82 instances but all outside of the Hil family. Below we will analyze these two cases separately.

### QEL63124

In the case of QEL63124, we found that it is highly similar to Hil1 except it lacks the N-terminal PF11765 domain. In fact, it is 94% identical and 95% similar to XP_028889033 (alignment starts at around residue 800), with 2% gaps (47 sites). See below for the annotated alignment.

![QEL63124.1 aligned to XP_028889033](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/QEL63124-XP_028889033-alignment.png)

Upon inspecting its [chromosomal location](https://www.ncbi.nlm.nih.gov/protein/qel63124), we found it is right next to the Hil1 protein in this strain, which is [QEL63125.1](https://www.ncbi.nlm.nih.gov/protein/QEL63125.1/). Their chromosomal locations are 

| Gene     | Chr  | CDS translated from                                          |
| -------- | ---- | ------------------------------------------------------------ |
| QEL63124 | 6    | complement(join(CP043447.1:935929..941539, 941629..942091,942537..943049, 943123..943147)) |
| QEL63125 | 6    | complement(CP043447.1:943433..944956)                        |

If these coordinates accurate (assembly is correct), they would suggest a tandem partial duplication. But given the highly repetitive nature of the C-terminal sequence, we cannot rule out the possibility of assembly error leading to a phantom protein...

### PIS58185

A total of four proteins contained the "GVVIVT" sequences and all are outside of the Hil family. They are:

| pID            | gID          | Length | Chromosome                     | Strain | Clade |
| -------------- | ------------ | ------ | ------------------------------ | ------ | ----- |
| PIS58185.1     | B9J08_000675 | 2608   | Chr2(scaffold3):351970..359796 | B8441  | I     |
| QEO22553.1     | NA           | 970    | Chr3:1752934..1755846          | B11220 | II    |
| XP_028893057.1 | CJI97_000676 | 1385   | Chr2:1465685-1470012           | B11221 | III   |
| QEL60526.1     | CJJ09_002636 | 1600   | Chr2:1449654..1454456          | B11245 | IV    |

From this table our guess is that except for QEO22553.1, the others are probably orthologs.

**Update 2021-07-19 [HB]** Further investigation suggested that proteins #3 and #4 are likely orthologs as they are both on chromosome 2 in different strains, with similar coordinates. The shorter length of the B11221 protein is because it is translated from a partial mRNA, which lacks the C-terminal portion. This also leads to it missing the C-terminal GPI-anchor signal peptide, which I expect it to have. PS58185 is different in that it is much longer, and because chromosome 1 in B8441 is split between two scaffolds, it is unclear whether its chromosomal location is syntenic with the ones in B11221 and B11245. Finally, QEO22553 is on a different chromosome and is much shorter. Below is the [COBALT](https://www.ncbi.nlm.nih.gov/tools/cobalt/cobalt.cgi) MSA result:

![COBALT alignment](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/20210719-PIS58185-four-seq-cobalt-aln.png)

_red color indicates highly conserved columns while blue color indicates less conserved ones._

We then used PIS58185.1 as query and searched against the non-redundant proteome database with blastsp. The result is stored in `output/PIS58185/20210709-PIS58185-blastp-in-cauris.txt`. Below is a graphic annotation of the search result:
![blastp search for PIS58185 in _C. auris_](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/20210709-PIS58185-blastp-in-cauris.png)

This is rather interesting: Hil1-4 are the longer Hil family members in _C. Auris_, which also have regularly spaced GVVIVTT sequences, and they are the ones that showed up in this search, suggesting that the C-terminal sequence of PIS58185 bear significant similarity with Hil1-4. To see how similar is PIS58185 to Hil1-4, we aligned it to the Hil1 sequence XP_028889033 and got the following:

![PIS58185 aligned to XP_028889033](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/PIS58185-XP_028889033-alignment.png)

The result revealed that PIS58185 has significant similarity with XP_028889033 in the non-NTD portion. Unlike in the case of QEL63124 however, there is substantial sequence differences behind the similarity, and therefore we can be pretty confident that this is not due to misassembly, as we suspected for QEL63124. Interestingly, Hil1-4 has GVVIVTT while PIS58185 has GVVIVT. A separate [analysis](https://github.com/binhe-lab/C037-Cand-auris-adhesin/tree/master/02-case-studies/07-Cauris-polymorphism/output/dot-plot) that included Hil1-8 showed that the tandem repeat unit, which contains the GVVIVTT motif, likely had a common origin during evolution among Hil1-4 and Hil7-8, which, after subsequent evolution, now contained different copies and also diverged in the repeat unit. Combined with the results above, we hypothesize that the C-terminal tandem repeats in PIS58185 has the same evolutionary origin as those in the Hil family. It's not possible to determine the exact evolutionary process without further analyses of the tandem repeats themselves though.

### Additional sequences

Three additional sequences also showed up. Two of them, PSK75098 and QEO22553, belong to B11243 and B11220 of clade IV and II respectively. They are both shorter than 1000 amino acids. The third, QEL63124, is the protein mentioned above. We aligned them using dot-dot plot to visualize their relationship.

![dot-dot-plot](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/01-global-adhesin-prediction/output/PIS58185/nonHil-proteins-to-investigate.jpg)

It appears that the first two proteins share the N-terminal domain but the latter has more repeats. The third one lacks any N-terminal domain and only has the repeats. It's not clear yet what the evolutionary relationship is among these proteins. What is clear is that they share significant similarities in their repeat content.
