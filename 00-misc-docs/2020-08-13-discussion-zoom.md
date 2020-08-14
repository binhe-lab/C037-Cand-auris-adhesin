---
title: Zoom discussion 10
author: Bin He
date: 2020-08-13
---

# Summary
Jan and Rachel presented their main findings from the global analysis so far, with some results pertaining to the case study.
- In Jan's PCA analysis
    - performed on the FungalRV positive set (identified from a great number of species' proteome)
    - species labels appear to be mixed (although combining the _C. auris_ and merging the two _C. glabrata_ sets will help clean up the space) in the projection to the first two PCs
    - labeling the proteins by whether they passed the FaaPred criterion showed some correlation with the spread of the data. one possibility is that within this set of FungalRV predicted adhesins, perhaps FaaPred scores capture some information not included by FungalRV and thus help distinguish true positives from false positives. If that's true, then protein length appears to be a (simple) main contributor to the discriminating power.
    - protein length is also implicated in Rachel's analysis, where sequences longer than 1000 a.a. are much more likely to be predicted by FaaPred to be adhesins, and more likely to have GPI-anchor. TANGO predicted aggregation prone sequence doesn't appear to be different between short and long sequences.
- Following up on the PCA analysis
    - the original question we asked was, given the (FungalRV) predicted adhesin set, do _C. auris_'s putative adhesins show different features (as determined by PCA) than those from _C. albicans_? In other words, are adhesin proteins highly specific to species (may have evolved repeatedly from different raw genetic materials) or are they highly conserved and originated from a shared set of ancestral genes?
    - recognizing that the FungalRV predicted set have a lot of false positives, the question turned to whether we can use other approaches to call true vs false adhesins and use PCA to test which predictor, e.g. length, is the most effective in discriminating between true and false positives. if successful, this would _enhance_ the existing prediction algorithm by providing an additional layer of filter, and can also serve as criteria for prioritizing candidate genes for experimental investigation.
    - to do so, it is crucial to have a positive and negative set. Authors of the FungalRV and FaaPred tools curated a positive set based on the literature, so does the Lipke review. This would be a place to start.
    - negative sets: FungalRv and FaaPred chose cytoplasmic proteins. however, Jan and Rachel are concerned that this may lead to the inclusion of many false positives, which are non-adhesin cell wall proteins that otherwise share the same features as the adhesins in terms of GPI-anchor and perhaps other properties. one idea is to curate a set of cell-wall proteins known _not to be_ adhesins. however this may be hard or impossible depending on the availability of time and what is in the literature.
- Rachel's summary
    - We need a positive and negative dataset to get meaningful information from the characteristics we are compiling in the database.
    - In positive FRV hits, amino acid length is correlated with the proteins passing faapred, containing a signal peptide, being GPI anchored, having aggregation sequences, and containing tandem repeats.
    - The distributions of percent of sequence in aggregation sequences vary with species, but tend to be ~1-15%.
    - The distributions of percent of sequence in tandem repeats vary with species, but can be up to ~60%.
    - The motif containing the GVVIVTT aggregation sequence matches appears in a variety of sequences in MAST, but is limited outside of the Clavispora in BLAST.
    - To further sum up, the characteristics that Rachel has looked into don't really distinguish the FRV predicted adhesins in different species.
 
# Todo and next meeting topic
- [ ] Assembled a positive and negative adhesin dataset
    - [ ] the FungalRV and FaaPred training set
    - [ ] from Peter Lipke review
    - [ ] use PFam and CDD annotation to nominate putative adhesins (grouped by OrthoMCL)
    - [ ] curate a set of non-adhesin fungal cell wall proteins

Next meeting will be next Monday, when the Lindsey and Bin will summarize their major findings so far, focused on the case study.

