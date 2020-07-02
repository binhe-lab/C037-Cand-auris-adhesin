---
title: Zoom discussion 5
author: Bin He
date: 2020-07-02
---

# Summary
Lindsey presented the latest results on the case (XP_028889033 homologs) study. Main results include
1. We identified this family through the search for the Hyphal-regulated-cell-wall-protein PFam domain, with _C. albicans_ _IFF11_ as the model
    - Interpro analysis of XP_028889033 shows an additional GPI-anchored cell wall protein repeat in addition to the domain above. Unclear what this domain, which repeats >30 times, does.
    - The Hyp-reg-CWP domain is mostly restricted to yeasts, with 4 matches in the Alphaproteobacteria
1. Gene tree colored in similar ways as Jan's
1. Tried to use XStream and MEME results to see if the low complexity repeats in the C-terminal region of the homologs, which was not included in the construction of the tree, cluster similarly as the N-terminal based tree.
    - Unfinished

## Unsolved questions regarding the C-terminal repeats
The C-terminal repeats require more thinking. In terms of its functional significance to the putative adhesin, we know that the LCR forms a rigid stalk (for that, it needs to be serine and threonine rich, which allows for heavy N-glycosylation). Jan's presentation last time pointed out that the beta-aggregation motifs within them are potentially crucial as well. Phylogenetically speaking, the null expectation is that more closely related sequences will also share their C-terminal repeats. But how quickly do they evolve, both in terms of the repeat units and in the number of repeats? Can we analyze this case study protein family in detail with respect to the repeats, and come up with metrics that we can apply to the genome-wide datasets?

A related question is about which tool to use for identifying and analyzing repeats. Rachel and Lindsey both liked the MEME suites. Other choices are tandem-repeat-finders like Xstream, Albert's maximal program, or, if our goal is to locate a given motif (with some fuzzy search) in other sequences, such as the case of the beta-aggregation motif Jan presented, a simple pattern match program would suffice.

# Other updates
- Rachel has updated the SQL database
- Bin worked out a pipeline to extract, align and reconstruct the gene tree for any given sequence sets, using RAxML on the cluster.

# Todo and next meeting topic
1. We decided that the focus should be on finishing the case study, as only by getting detailed understanding of the gene evolutionary history and the low complexity repeat in a high confidence dataset can we derive principles that we will apply to a larger dataset.
1. To this end, Bin and Lindsey are independently working on the gene tree with a new BLAST search to include non-pathogenic species into the tree.
1. Rachel has been working with the Tangle tool.
1. A realistic goal is to learn a lot more about the homologs of XP_028889033 -- are the homologs all predicted to be adhesins? Do they share the low complexity repeats and the beta-aggregation motifs in them? are their C-terminal regions rich in S/T?

scheduled for the Monday after next week, 13th July, 3:30-4:30 pm
