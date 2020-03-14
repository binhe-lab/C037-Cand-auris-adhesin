---
title: Protein family classification for predicted adhesins in all five genomes 
author: Bin He
date: 2020-03-12
---

_Question_

Did _C. auris_, _C. albicans_ and _C. glabrata_ inherit the same set of adhesin families? In other words, do they use an ancestral pool of adhesin genes or did they "come up with" species-specific adhesins, by co-opting or _de novo_ evolution? If they share certain families, are the number of paralogs (members of a family) similar or different?

_Approach_

Our goal is to map the predicted adhesins from all five genomes to "orthogroups", which are pre-computed groups of putative orthologous protein sequences. These are calculated using the OrthoMCL program. Here is a [description](https://orthomcl.org/orthomcl/about.do#background) of how that is done. Briefly

- All-v-all BLASTP of the proteins.
- Compute percent match length
    - Select whichever is shorter, the query or subject sequence. Call that sequence S.
    - Count all amino acids in S that participate in any HSP (high scoring pairs, from BLAST local alignment).
    - Divide that count by the length of S and multiply by 100
- Apply thresholds to blast result. Keep matches with E-Value \< 1e-5 percent match length \>= 50%
- Find potential inparalog, ortholog and co-ortholog pairs using the Orthomcl Pairs program. (These are the pairs that are counted to form the Average % Connectivity statistic per group.)
- Use the MCL program to cluster the pairs into groups

On 2020-03-10, I (Bin He) submitted all predicted adhesins to the workflow for mapping proteins to orthogroups, made availabe by EuPathDB's Galaxy site (see `output/OrthoMCL` for details). In this folder, I'm analyzing the output to answer the above questions.
