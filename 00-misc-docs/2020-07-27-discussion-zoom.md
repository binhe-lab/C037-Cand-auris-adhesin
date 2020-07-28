---
title: Zoom discussion 8
author: Bin He
date: 2020-07-27
---

# Summary
This is a quick update on last week's results. Main changes include
- New set of homologs include hits from _K. lactis_ and several Nakaseomyces group species. Several sequences in the previous set were excluded due to sequence lengths being shorter than 500 a.a.
- Due to the identification of homologs in _K. lactis_ and Nakaseomyces group, I find the Horizontal Gene Transfer theory unlikely (invoked previously to explain the observation of homologs only in _C. glabrata_ and _N. castellii_). Instead, it looks like the protein family is ancient and has been lost repeatedly in many species, while expanded quite rapidly in the MDR clade that includes _C. auris_, as well as in the tri-species group that includes _C. albicans_. This is perhaps the most interesting observation in this part of the analysis so far.
- Previous FungalRV results obtained through the webapp appears to be wrong (see `../02-case-studies/output/homolog-properties/README.md` for details). I reran the FungalRv script locally and the results matched what we got before for XP_028889033. Using the new results as well as the GPI-SOM and PredGPI results, I further confirmed that the expanded family members in the MDR clade and the tri-species _albicans_ clade are likely to be functional adhesins (predicted by FungalRV+FaaPred, and are predicted to be GPI-anchored by both programs)
- I rewrote the function in R to parse the tango output. By avoiding loops, the function is more efficient and can be useful if we want to test different thresholds while processing large proteome-scale datasets.
- Did a number of exploratory analyses:
    a. Both median and 90th quantile of the aggregation potential of a motif increases with motif length, i.e. longer tango motifs in general have higher median and 90th quantitle beta aggregation probability. This trend is true till ~17bp.
    a. There appears to be **two peaks** in the distribution of the location of the motifs along a sequence, one in the first 300 a.a. and another after that, peaking at ~1000 a.a.
    a. Most motifs are between 5-10 a.a. The longer ones tend to occur towards the front of the sequence?
- Tried to use `stringdist` package to calculate pairwise distance between the 898 unique tango motifs identified from the 100 input sequences. Using the "DL" method followed by Ward's method for hierarchical clustering, I was able to recover the "GVVIVTT" and its variants as one cluster. The threshold for recovering this cluster is `k = 60` or `h = 12`, the latter of which resulted in 108 distinct clusters (too many?) using the `cutree()` function on the `hclust` object. Better methods for grouping the motifs would be desirable.

# Todo and next meeting topic
- [ ] Explore the gene annotation for BLAST hits with relatively high E-values (between 1E-5 to 1E-20), to test if we get more meaningful homologs by making the criteria more stringent.
- [ ] Look for other ways to group motifs, including alternative ways to calculate the pairwise distance between peptides that take into account the amino acid substitution matrix, and explore the use of MEME to group motifs.
- [ ] Rerun FungalRV locally for the recently expanded proteome datasets to make sure that the results Rachel is getting from the website are correct.

Next meeting will be next Monday, when Lindsey will give an update on the structural analysis of XP_028889033. Jan will have updates on the PCA results she has been working on during the week after.
