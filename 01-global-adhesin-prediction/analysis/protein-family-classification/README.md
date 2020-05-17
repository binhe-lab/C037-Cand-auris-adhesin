---
title: Protein family classification for predicted adhesins in all five genomes 
author: Bin He
date: 2020-03-12
---

## 2020-03-12 [HB] Motivation for this analysis

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


## 03/16/2020 [RS] OrthoMCL Information

Algorithm information is [here](https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub) and protocol information is [here](https://currentprotocols.onlinelibrary.wiley.com/doi/full/10.1002/0471250953.bi0612s35)

## 2020-03-20 [HB] Re-ran OrthoMCL mapping for all fungalRV predicted adhesins

1. Concatenated all FungalRV predicted adhesins to a single fasta file
1. Upload onto [OrthoMCL galaxy site](https://eupathdb.globusgenomics.org/) and run the pipeline
1. There are two result files, the `MCS.tabular` and the `mappedGroups.txt`. The former contains sequences not mapped to any existing Orthogroups, and are further clustered using the MCS algorithm.
1. I manually edited the `MCS.tabular` so that each row is a protein sequence and the same cluster (at most three in a cluster) gets an arbitrary MCS_# number.
1. On Galaxy OrthoMCL pipeline, I varied the "inflation" parameter for the MCS program according to the program's suggestion. the default is 4, and I changed it 1.4 and 2.0  Neither changed the results.

## 2020-05-15 [HB] Learn how OrthoMCL-DB tool deal with proteins that have no hit to their precomputed groups
According to Fischer et al. 2011, under _How the tool processes your proteins_, the authors explained:

> _Phase 1_
> In this phase the tool maps your proteins to groups in OrthoMCL-DB. It performs a BLASTP against all the proteins in OrthoMCL-DB, using a cutoff of e-5 and 50% match. Your protein is assigned to the group containing its best hit. If the best matching protein does not have a group, it is assigned to NO_GROUP.
>
> _Phase 2_
> In this phase the tool processes all your proteins that did not have an above-threshold match in phase 1. It uses the OrthoMCL-DB in-paralog algorithm described in the OrthoMCL Algorithm Document to create pairs of potential in-paralogs. It then submits those pairs to the MCL program for clustering. The result is groups of your proteins that provisionally represent in-paralogs.

So basically, any proteins that don't have a hit in the OrthoMCL database will be subject to the MCL (Markov Clustering Algorithm) for identifying potential in-paralogs. It also tells us that the majority of the proteins that do have hits in the database are not even processed with the MCL algorithm.

## 2020-05-15 [HB] Re-process the FungalRV predicted adhesins using the VEuGalaxy's OrthoMCL workflow, but changing to v6r1 of the databased released in April 2020
By comparing the results from v5 and v6, I found that both version would leave some input sequences unmapped.
