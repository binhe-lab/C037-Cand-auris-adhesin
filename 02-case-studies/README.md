---
title: Detailed analyses on selected cases of adhesins in _C. auris_
author: Lindsey Snyder, Rachel Smoak
date: 2020-03-12
---

This folder contains analyses of one family of putative adhesins in _C. auris_. Some analyses, such as phylogenetic tree and structural prediction, are not easy to scale up and thus we use a few examples to highlight the findings. This protein family was initially identified by Lindsey and Rachel in their 2019 Bioinformatics course project, in which they used the Pfam database to first locate a domain associated with fungal adhesion (Hyphally regulated Cell Wall Protein or PF11765) and then found two _C. auris_ proteins containing that domain.

**Update 2021-04-03 [HB]**

Updated the folder structure so that each type of analysis has its own folder and ideally are organized into the standard fold structures. I will go through the subfolders and reorganize them over time.

**Update 2021-05-15 [HB]**

Updated the folder structure again so the sub-analyses are each in their own folder and directly under the `02-case-studies` parent folder. A new folder, named `shared`, now holds the shared data, script and doc files.

# Content

| Folder | Description |
| ------ | ----------- |
| Gene-tree | Phylogenetic analysis |
| I-TASSER | Structural prediction by threading |
| Phyre | Popular structural prediction based on homology modeling |
| blast | Identify and select homologous sequences |
| gene-tree | Reconstruct the gene tree and infer the protein family's evolutionary history |
| homolog-properties | Run adhesin predictors and other software to characterize the homologs of the _C. auris_ putative adhesin |
| XP_028889033_drawing | Draw domain architectures for XP_028889033; can be used for other homologs as well |
