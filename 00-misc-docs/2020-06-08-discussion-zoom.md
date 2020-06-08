---
title: Zoom discussion 3
author: Bin He
date: 2020-06-08
---

# OrthoMCL v5
- ~8 _C. auris_ proteins map to an orthogroup that has zero members in the other three species within the predicted adhesin set. Given that _C. auris_ is the only species NOT included in constructing OrthoMCL-DB v5, this observation deserves further investigation. Specifically
    - Is this because of the single score cutoff leaving the orthologs in the other species out of the dataset?
    - Or is this because _C. auris_ used proteins whose ancestral functions are not related to adhesion?
    - Or it could be that these _C. auris_ proteins are not adhesins, but false positives.
- Continue with analysis using v6r1, see if the results are consistent with v5. If not, which ones are different?
- Can I (HB) make the gene tree reconstruction an automated pipeline and examine more orthogroups, to see if the lineage-specific expansion seen in OG5_132045 is general or specific to a few groups.
- Don't discount the possibility that some seemingly unrelated domains, e.g. alcohol dehydrogenase, beta-glucosidase or glycosyl hydrolase, can exist in adhesin proteins.

# Todo
1. Investigate the new _C. glabrata_ genome [RS].
1. Gene tree for Lindsey's (and potentially Rachel's) adhesin family. [LFS] [JF]
    - are Lindsey and Rachel's proteins orthologs? [LFS] [RS]
1. Implement gene tree reconstruction pipeline (only for the four species included in the OrthoMCL analysis). [HB]
1. Build relational databases to make it easier to query the various results. [HB] [RS]
1. Structure analysis figure, draft, method and result. [LFS]

# Next meeting topic
1. Gene tree for Lindsey and Rachel's adhesin families.
1. Any other results worth discussion.
Time should be in the next 1-2 weeks.
