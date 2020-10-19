---
title: Zoom discussion 14
author: Bin He
date: 2020-10-19
---

# Summary
Rachel presented genomic locations analysis. Cool visualization and plotting. No obvious signs yet with regard to enrichment in the chromosomal ends.

# Discussion
## Scope of the paper
Instead of doing a "global" comparison to ask whether _C. auris_ and its neighbors harbor "novel" adhesins as compared to _C. albicans_, we believe even the case study already supported that conclusion: even though the case study proteins do have homologs in _C. albicans_ (IFF4) as judged by the N-terminal domain, a number of features, most notably protein length and presence of the GVVIVTT aggregation sequences in regularly spaced arrays, distinguish the _C. auris_ homologs from those in _C. albicans_ and _C. glabrata_. Conversely, the fact that the well studied ALS family in _C. albicans_ has only one or two homologs in each _C. auris_ strain also suggest differences in the adhesinome in the two species.

One possible flow of the paper would be to start with the case study and present the strong evidence for the protein family being bona fide adhesins in the MDR clade. After that, apply the rules we learned from the case study to analyze the complete proteomes in two well assembled _C. auris_ strains (B11221 and B11220?), to "nominate" candidate adhesins based on similar protein architectures. This include the N-terminal signal peptide (SignalP), C-terminal GPI anchor (PredGPI), aggregation sequences (TANGO) and Ser/Thr frequencies (custom script and freak). Independently, we can use the FungalRV and FaaPred to nominate another set of candidate adhesins in the same two proteomes. Call this dataset B and the previous one dataset A. Their intersection would be the high-confidence set, while the remaining in each dataset would be the second tier. For the second dataset, we could also pull in some of the existing results comparing the different species, asking if the FungalRV and FaaPred predicted adhesins in these species differ in number and protein architectural traits, such as GPI-anchor and protein length etc. (The PCA analysis Jan was working on).

# Todo and next meeting topic
- [ ] Perform the analyses used for the case study on two _C. auris_ proteomes [HB]
- [ ] Establish a table structure for curating positive sets for adhesins [JF]
- [ ] Finish analyzing the chromosomal locations and plot aggregated distributions (% chromosomal length instead of absolute locations) [RS]
- [ ] Start writing up the structural results [LFS]
