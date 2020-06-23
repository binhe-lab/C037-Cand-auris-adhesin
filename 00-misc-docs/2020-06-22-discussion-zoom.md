---
title: Zoom discussion 4
author: Bin He
date: 2020-06-22
---

# Summary
Jan presented the findings mainly on beta-aggregation potential and the sequence motifs behind. The driving question is this: based on what is known about the beta-aggregation motifs in the Als family proteins, do the two proteins that Lindsey and Rachel studied look anything like the Als'? The short answer is no. See Jan's slides on gDrive shared folder for details.

It is worth noting that both Lindsey's and Rachel's protein do have a short (7 a.a.) motif, GVVIVTT or some variaiton of it, arrayed in the second half of the protein. It seems that the three clades in Jan's gene tree have different characteristic repeat units. One question raised is whether other proteins in the same clades share this feature.

# Other updates
- Rachel has been working on incorporating the new _C. glabrata_ proteome. Interestingly, when she submitted all the sequences at once to FungalRV, she saw the same issue that Lindsey had seen, i.e. the tool returned thousands of candidates, way more than any other genome. But when she splitted the sequences in batches of ~200 and submitted them to the FungalRV sites, the results are very similar with the older version of _C. glabrata_. We suspect some kind of bug in the webapp. I (Bin) plan to run the local version of FungalRV to test.
- Rachel has also been constructing the relational databases using the RSqlite package. The databases are almost done, and queries are being tested.
- Lindsey has been working on reconciling the gene tree.
- Bin will be finishing up the v6r1 of OrthoMCL results, and writing up summaries.

# Todo from last time
1. **Done** Investigate the new _C. glabrata_ genome [RS].
1. **Done** Gene tree for Lindsey's (and potentially Rachel's) adhesin family. [LFS] [JF]
    - are Lindsey and Rachel's proteins orthologs? [LFS] [RS]
1. **Todo** Implement gene tree reconstruction pipeline (only for the four species included in the OrthoMCL analysis). [HB]
1. **In progress** Build relational databases to make it easier to query the various results. [HB] [RS]
1. **Todo** Structure analysis figure, draft, method and result. [LFS]

# New todo
1. Finish v6r1 OrthoMCL analysis. [HB]
1. Run tango on other sequences in Jan's gene tree. [JF] [RS]
1. Run FungalRV locally on the new _C. glabrata_ proteome. [HB]
1. Test Albert's "Maximal" algorithm as a way to get at the repetitive motifs? [HB]
1. Test to see if we can programmatically extract the beta-aggregation sequence motifs based on the Tango and XStream results. [RS]

# Next meeting topic
1. Reconciled gene tree [LFS]
1. Any other results worth discussing.

scheduled for next Monday, 29th June, 3:30-4:30 pm
