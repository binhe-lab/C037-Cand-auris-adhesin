---
title: Zoom discussion 9
author: Bin He
date: 2020-08-03
---

# Summary
Lindsey presented structural analysis result for XP_028889033
- Swiss-Model couldn't find any suitable template to perform homology modeling
- I-Tasser, which performs threading, was able to construct a model using a bacterial adhesin (PDB: 5NYO, from _L. reuteri_) as the "pipe". Sequence similarity between the _C. auris_ protein and the model used by I-Tasser is very low.
- Model C-score is -2.5, which suggests that the overal shape of the model may not be correct. But the RMSD and other measures are reasonable.
- Dolly search identifies similar structures to the template used, and they belong to CATH family, with the $Beta$-solenoids fold.
- A paper describing the structure of the bacterial protein suggested that several features of the solenoids fold may facilitate its function as an adhesin, including a large surface for ligand interaction, propensity for self-adhesion etc.

# Questions and ideas
- Jan suggested digging further into the bacterial adhesin's literature, in order to gain further insight into the structure-function relationship.
- Jan also wondered if phage could serve as an intermediate for horizontal gene transfer.
- My (Bin) idea is that maybe the bacterial protein and the fungal protein represent convergent evolution from different ancestral genetic materials, reaching the same overal shape and similar functions.
- Jan and Rachel wondered if the PFam domain named Hyphally-regulated-domain, which is how Lindsey and Rachel identified their proteins in the first place, could all be modeled based on the $Beta$-solenoids fold.
- Conversely, I (Bin) wondered if the proteins among the predicted adhesins that have a hit to the same CATH family can be modeled with this bacterial protein.
- Is the C-terminal region of XP_028889033 rich in Serine/Threonin as the bacterial protein does?

# Todo and next meeting topic
- [x] Perform blastp/HMMER search for XP_028889033 in phages/bacteria
- [ ] Examine the frequency of S/T/C in the C-terminal region of XP_028889033

Next meeting will be next Monday, when the four of us will take turns to summarize our major findings so far, and we will discuss our next steps.

# Update 2020-08-09 HB
- HMMER and blastp search for NTD of XP_028889033 specifically in bacteria. See [blast README.md](../02-case-studies/output/blast/README.md)
