---
title: Notung 2.9 reconciling gene tree with species (strain) tree.
date: 2021-04-23
author: Bin He
---

1. Gene tree is copied from `../with-outgroup/RAxML_bipartitions.clustalo_4921862` and manually edited to replace the _C. auris_ sequence names to allow for reconciliation, e.g. PSKXXXX_B11243_Cauris -> PSKXXXX_Cauris.B11243. This is done in Vim with the command `:s/\(B\d\+\)_Cauris/Cauris\.\1/g`.
1. Also corrected one strain name: it should be 6684, not B6684. It is the first draft genome available for _C. auris_, released in 2015. According to Muñoz 2018, this strain belongs to Clade I. Its genome is not assembled as well as the other four, with 99 contigs and potentially many gaps. As will be seen below, it's missing several of the homologs, likely due to its incomplete genome assembly.
1. Created a species (strain) tree manually in Newick format.
1. Ran rooting analysis, which identified _D. hansenii_ as the outgroup as expected
1. Rearranged the tree with 80% bootstrapping value cutoff.
1. Colored the _C. auris_ strains based on the scheme used in Muñoz et al. 2021 Genetics paper.
