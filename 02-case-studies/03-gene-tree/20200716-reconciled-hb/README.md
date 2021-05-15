---
title: 
author: Bin He
date: 2020-07-16
---

To reconcile the gene tree constructed with RAxML on 2020-07-14

## Notes
### 2020-07-16 [HB]
1. ClustalO and Muscle based trees are very similar if not identical.
1. Saved the reconciled and rearranged tree both as the NHX format (an extension of the Newick) and as the native Notung format (NHX + additional annotation details).
1. Notung also provides easy to use annotation features, including coloring the leaf nodes using a simple substring match.
    - color annotation exported and can be used on any tree in Notung with the same leaf nodes!
1. Next I want to collect more statistics about the sequences in this tree. See README in the `02-case-study/analysis/README.md`.
### 2020-07-22 [HB]
- Investigated if an alternative choice of the root will make more sense. I tried the alternative root -- second best suggested by the rooting analysis in Notung -- on the branch that contains _C. lusitaniae, C. glabrata, N. castellii_ and one _S. stipitis_ sequence. The resulting tree doesn’t make much more sense than the one that roots on _C. glabrata_ and _N. castellii_.
