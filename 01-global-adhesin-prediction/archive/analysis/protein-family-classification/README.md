---
title: Protein family classification for predicted adhesins in all five genomes 
author: Bin He
date: 2020-03-12
---
Table of Contents
=================

   * [Summary](#summary)
   * [Content](#content)
   * [Notes](#notes)
      * [2020-03-12 [HB] Motivation for this analysis](#2020-03-12-hb-motivation-for-this-analysis)
      * [03/16/2020 [RS] OrthoMCL Information](#03162020-rs-orthomcl-information)
      * [2020-03-20 [HB] Re-ran OrthoMCL mapping for all fungalRV predicted adhesins](#2020-03-20-hb-re-ran-orthomcl-mapping-for-all-fungalrv-predicted-adhesins)
      * [2020-05-15 [HB] Learn how OrthoMCL-DB tool deal with proteins that have no hit to their precomputed groups](#2020-05-15-hb-learn-how-orthomcl-db-tool-deal-with-proteins-that-have-no-hit-to-their-precomputed-groups)
      * [2020-05-15 [HB] Re-process the FungalRV predicted adhesins using the VEuGalaxy's OrthoMCL workflow, but changing to v6r1 of the databased released in April 2020](#2020-05-15-hb-re-process-the-fungalrv-predicted-adhesins-using-the-veugalaxys-orthomcl-workflow-but-changing-to-v6r1-of-the-databased-released-in-april-2020)
      * [2020-05-22 [HB] Thoughts and next set of questions with the OrthoMCL analyses](#2020-05-22-hb-thoughts-and-next-set-of-questions-with-the-orthomcl-analyses)
      * [2020-05-28 [HB] Examine top orthogroups and gene functions](#2020-05-28-hb-examine-top-orthogroups-and-gene-functions)
      * [2020-05-29 [HB] Next step questions](#2020-05-29-hb-next-step-questions)
      * [2020-06-05 [HB] Todo list](#2020-06-05-hb-todo-list)
      * [2020-06-06 [HB] Continue with OrthoMCL analysis](#2020-06-06-hb-continue-with-orthomcl-analysis)
      * [2020-06-12 [HB] Executive summary of the analysis of OrthoMCL-DB v5 results](#2020-06-12-hb-executive-summary-of-the-analysis-of-orthomcl-db-v5-results)
      * [2020-06-12 [HB] Observations based on the latest version of 'orthomcl-gene-exploration.Rmd'](#2020-06-12-hb-observations-based-on-the-latest-version-of-orthomcl-gene-explorationrmd)
         * [FungalRV stringent (Score &gt; 0.511)](#fungalrv-stringent-score--0511)
         * [FaaPred (FungalRV Score &gt; 0)](#faapred-fungalrv-score--0)
      * [2020-06-13 [HB] Next step](#2020-06-13-hb-next-step)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Summary

The goal of this analysis is to answer the question "what are the evolutionary relationships between the predicted adhesins in _C. auris_, _C. albicans_ and _C. glabrata_?". The reason for this quesiton is because we want to distinguish two hypotheses about the origin and evolution of adhesin genes:
1. Adhesin genes were ancestral and inherited by the descendent species, such as _C. albicans_ and _C. auris_ (_C. glabrata_ is more distantly related, but the same question applies).
1. Adhesin genes were mostly species-specific, meaning that they evolved in each species from non-adhesin genes, or _de novo_ from non-coding DNA.

* [Table of Contents](#table-of-contents)
# Content
Our approach to answer this question and the results are documented in the R markdown files. Below are the links to view their results as HTML:

| File | Description | Link | 
|------|-------------| ---- |
| OrthoMCL.Rmd | Compare OrthoMCL-v5 and v6r1 results, initial summary (replaced by the new analysis below) | https://htmlpreview.github.io/?https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/analysis/protein-family-classification/OrthoMCL.nb.html |
| OrthoMCL2-v5.Rmd | Test new ideas, like limiting to the FaaPred predicted, and add _S. cerevisiae_ genes | https://htmlpreview.github.io/?https://github.com/binhe-lab/C037-Cand-auris-adhesin/blob/master/01-global-adhesin-prediction/analysis/protein-family-classification/OrthoMCL2-v5.nb.html |
| orthomcl-gene-exploration.Rmd | A shiny app for interactive exploration of the OrthoMCL result! | https://binhe-lab.shinyapps.io/orthomcl-gene-exploration/ |

Other files

| File | Description |
|------|-------------|
| S_cerevisiae_orthoMCL_v5_download.txt | Directly downloaded from [FungiDB Release 46](https://fungidb.org/fungidb) |
| orthomcl-v5-mapping-analysis-cache.RData | Saved image generated by OrthoMCL2-v5.Rmd, used by the shiny app |
| scer_id.txt | a list of ref_protein IDs for _S. cerevisiae_ genes |

* [Table of Contents](#table-of-contents)
# Notes
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


* [Table of Contents](#table-of-contents)
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

* [Table of Contents](#table-of-contents)
## 2020-05-15 [HB] Re-process the FungalRV predicted adhesins using the VEuGalaxy's OrthoMCL workflow, but changing to v6r1 of the databased released in April 2020
By comparing the results from v5 and v6, I found that both version would leave some input sequences unmapped. This is largely because the OrthoMCL-DB v5 and v6r1 contain different number of sequences. The v6r1 is much larger, because it contains a lot more species. What's unclear to me is why some sequences can map to v5 but not v6r1 -- it seems some orthogroups present in v5 are dropped in v6r1.

## 2020-05-22 [HB] Thoughts and next set of questions with the OrthoMCL analyses
1. OrthoMCL is different from PFam or EC, which group genes based on the putative or demonstrated functions. Here genes are grouped based on evolutionary relationship, inferred from sequence similarity. That is to say, genes with similar functions, e.g. adhesins, may not belong to the same orthogroup. This is exactly what I intended, since my initial question is an evolutionary one: are adhesin genes in _C. auris_ belong to the same orthogroups as those in _C. albicans_ and _C. glabrata_? In other words, did all three species _inherit_ the same set of genes with adhesin functions, or did they each evolve new adhesin proteins that are evolutionarily _unrelated_ (meaning they didn't descend from the same ancestral gene or gene family in their common ancestor)?
1. In practice, the orthogroups are just guesses at the evolutionary relationship. The Markov Clustering Algorithm also has an inflation ratio parameter that defines how "tight" the clusters are. All these mean that the orthogroup definitions are somewhat arbitrary.
1. That being said, the OrthoMCL-DB is based on a very large number of proteomes (predicted for most species, I think) and thus is likely to capture a lot of the ancient families. Gene families that are more phylogenetically restricted are more likely to be missed, if the species in which they exist are not well sampled. This shouldn't be the case for fungi, and especially not a problem for the _Saccharomycotina_ order.
1. Under the above considerations, I think I have to take the evidence from the OrthoMCL analyses as saying most of the adhesins don't belong to the same orthogroups in the three species.

## 2020-05-28 [HB] Examine top orthogroups and gene functions
- I separated the gene annotation part from the `orthomcl.Rmd`, which include the exploratory analyses with two versions of OrthoMCL-DB, and some summary statistics of the mapped genes in the five proteomes.
- I made a new `orthomcl-gene-exploration.Rmd`, which uses a `shiny` app to allow interactive exploration of the gene functions. The annotations were fetched from the Conserved Domain Database based on the ref_protein IDs.
- I manually examined the top 10 orthogroups. The top 5 clearly make sense -- the CDD showed that members were annotated as cell wall proteins or adhesins. Some of the other orthogroups, however, don't seem to make a lot of sense, e.g. alcohol dehydrogenase, HSP12 heat shock protein. Quite a few of the orthogroups represent enzymes, such as the glucosidase, aspartyl protease and glycosyl hydrolases. One orthogroup, represented by CaKre9 that is likely involved in cell wall regulation.

* [Table of Contents](#table-of-contents)
## 2020-05-29 [HB] Next step questions
1. Some of the orthogroups based on all of the fungalRV prediction results seem unrelated to adhesion. How about the FaaPred filtered ones?
1. Can we use the orthoMCL results and other protein sequence features, such as CATH, GPI-anchor prediction, signal peptide prediction, chromosomal location (in telomeric regions?) and low complexity repeat regions.
1. Can we add _S. cerevisiae_ results and get a bit more clarity?

_todo_

1. add FaaPred (Y/N) to the gene table
1. add _S. cerevisiae_ to the gene table, including its orthogroup mapping
1. start a new Rmd by duplicating the previous one, use a sandbox folder?

## 2020-06-05 [HB] Todo list
1. Merge _S. cerevisiae_ results, add FaaPred flag, and repeat the orthomcl results
    - percent of predicted adhesins mapped
    - merge the three _C. auris_ adhesin sets
    - proportion of predicted adhesins belonging to an orthogroup that is shared by at least two genomes
1. Examine top orthogroup functions
1. Export the sequences belonging to an orthogroup and explore their evolutionary relationship.

## 2020-06-06 [HB] Continue with OrthoMCL analysis
1. Downloaded orthogroup and other gene information for the four species (for _C. auris_ only B8441 is provided) from FungiDB beta (more details see `../../output/OrthoMCL/README.md`
1. When examining gene members in a single orthogroup, I asked myself what does it mean when one species have multiple members in that orthogroup? Were they species specific duplicates or were they ancient duplications shared across several species? To answer this question, I tested one orthogroup, OG5_132054, by performing alignment and tree reconstruction. See `../../output/OrthoMCL/all-fungalRV-orthoMCL-v5/README.md` for details. (pasted below)

### Gene tree reconstruction
1. Sequence names were stored in the `OG5_xxxxxx.txt` file, which was exported from R (`../../../analysis/protein-family-classification/OrthoMCL-v2.Rmd`).
1. The `faa` file was generated using the `extract_fasta.py` script.
1. The fasta file was opened in Jalview, and the first 499 aa of each sequence were selected and exported to a new window (I intend to make this part of the `extract_fasta.py` as an additional option).
1. ClustalO was used to aligne the newly created file within Jalview, with **50 combined iterations and 1 guide tree**. The aligned file was stored as `OG5_132045_N500_aln.faa`. I intend to make this programmatic.
1. Run RaxML

    I installed RaxML based on the instruction 

    ```bash
    $ raxmlHPC-PTHREADS-SSE3 -m PROTGAMMAWAG -p 12345 -s OG5_132045_N500_aln.faa.fa -# 20 -n test
    ```

    Parameters based on [RaxML Manual v8.2.X](https://cme.h-its.org/exelixis/resource/download/NewManual.pdf)

    > `-m` protein substitution matrix; `-p` random number seed; `-s` input sequence; -# specify the number of alternative runs on distinct starting trees,  e.g., if ­# 10 or ­N 10 is specified, RAxML will compute 10 distinct ML trees starting from 10 distinct randomized maximum parsimony starting trees

    Results are stored in a folder named "raxml" under the respective OG5_xxxxx folder.

    The most important files are the `info`, `log` and `bestTree`

* [Table of Contents](#table-of-contents)
## 2020-06-12 [HB] Executive summary of the analysis of OrthoMCL-DB v5 results
1. _C. auris_ (all three strains) have fewer genes predicted by either FungalRV or FaaPred to be adhesins (47 by FungalRV, vs ~60 in _S. cerevisiae_ and _C. glabrata_ and 84 in _C. albicans_)
    - This lower number could be a result of 1) the model was trained on positive adhesins sets that _included_ the three non _auris_ species, and thus can be more sensitive to them, or 2) _C. auris_ genome is less complete. Being more closely related to _C. albicans_ and yet having far fewer predicted adhesins suggests that either adhesins are highly species-specific, or that the _C. auris_ genome is not as well assembled. I'm not sure genome assembly is the issue.
1. The proportion of predicted adhesins mapped to an existing orthogroup in OrthoMCL-DB v5 is much lower (60%) than the other three species (80-90%), possibly because _C. auris_ is the only species not included in constructing the OrthoMCL v5
1. Examining the gene tree for one of the orthogroups shows that the many members in that orthogroup duplicated in each of _C. auris_ and _C. albicans_ after they diverged from each other!
1. Classify each orthogroup in the dataset by how many species have members in that orthogroup (1,2,3 or 4), and compare the proportion of predicted adhesins in each species that fall in one of the groups or "unmapped". This shows that more than half of the predicted adhesins are either "unmapped" or mapped to an orthogroup that is only represented by that species alone.
    - Using various stringency criteria (FRV score > 0 or 0.511, with or without FaaPred positive), I found that the proportion of unmapped and species-specific orthogroups remain roughly the same (>50% for _S. cerevisiae_ and _C. albicans_, ~50% for _C. auris_ and _C. glabrata_). One interpretation, given the first two species are far more studied and better represented in the adhesin positive set, is that the predictor is more sensitive for species-specific adhesins in these two species, which would imply a high proportion of species-specific adhesins.
    - Looking at the FungalRV score distribution for the above five groups didn't show lower scores for the unmapped.
    - In _C. albicans_ and _S. cerevisiae_, the predicted adhesins belonging to orthogroups shared by 2 or 4 species have higher scores than those in species-specific orthogroups. Combined with the observation that these two species have higher number of predicted adhesins falling in species-specific orthogroups suggest to me that those ones are less trustworthy.
    - In all four species, the orthogroups with members in 3 species are the smallest in number and the adhesins in them tend to have the lowest scores. Knowing that the four species form two pairs of relatively closely related groups suggest to me that those orthogroups shared by 3 species are less trustworthy (haven't thought carefully about what may cause these).
    - _C. glabrata_ has a lot of unmapped adhesin predictions, which have comparable FungalRV scores as the other groups, suggesting that this species may have evolved new adhesins since it diverged from _S. cerevisiae_.
- I'll leave the functional annotation for the top orthogroups to the other `orthomcl-gene-exploration.Rmd`.

* [Table of Contents](#table-of-contents)
## 2020-06-12 [HB] Observations based on the latest version of 'orthomcl-gene-exploration.Rmd'
I finished updating the shinyapp to include all results based on OrthoMCL-DB v5. Four different subsets can be queried individually, corresponding to different selection criteria (liberal to stringent). Below are my summary of the observations:

### FungalRV stringent (Score > 0.511)
| Group_id   | Caur| Calb | Cgla | Scer | Putative function (based on Conserved Domain Database unless noted) | 
|------------|-----|------|------|------|---------------------------------------------------------------------| 
| OG5_126579 | 3   | 8    | 5    | 11   | ALS family                                                          | 
| OG5_132045 | 8   | 8    | 0    | 0    | Hyr1 family, hyphally regulated cell wall GPI-anchored protein 1    | 
| OG5_152943 | 0   | 0    | 14   | 0    | _C. glabrata_ specific, members contain domains such as<br>CAGL0J05159g: "Hyphally regulated cell wall protein N-terminal"<br>CAGL0I10362g: "bacterial beta-glucosidase", "GLEYA domain, lectin-like binding found in _S. cerevisiae_ Flo proteins" | 
| NO_GROUP   | 1   | 4    | 3    | 0    | _C. glabrata_ CAGL0E06600g: Hyphally regulated cell wall protein N-terminal, Flocculin repeat | 
| OG5_132246 | 0   | 0    | 5    | 1    | includes _S. cerevisiae_ Flo10, similar domains as the 3rd orthogroup above | 
| OG5_136169 | 1   | 1    | 1    | 2    | Beta-glucosidase (SUN family) _C. albicans_ _SUN41_: Cell surface beta-glucosidase involved in cytokinesis, cell wall biogenesis, adhesion to host tissue, and biofilm formation [UniProt](https://www.uniprot.org/uniprot/Q59NP5) | 
| OG5_138681 | 1   | 1    | 1    | 1    | Glycosyl hydrolase, _C. albicans_ member has "cell wall organization" [UniProt](https://www.uniprot.org/uniprot/A0A1D8PNW1) | 
| OG5_145217 | 0   | 2    | 1    | 1    | Flocculin type 3 repeat, pfam13928, including _S. cerevisiae_ _CCW12_ | 
| OG5_126661 | 1   | 1    | 0    | 1    | Alcohol dehydrogenase GroES-like domain<sup><em>1</em></sup> | 
| OG5_159685 | 0   | 0    | 2    | 1    | _S. cerevisiae_ _DAN4_: component of the cell wall, extensively O-glycosylated, GPI-anchor [UniProt](https://www.uniprot.org/uniprot/P47179) | 
| OG5_160783 | 0   | 1    | 2    | 0    | _C. albicans_ _PGA62_: fungal cell wall organization, N- and O-glycosylated, GPI anchor [UniProt](https://www.uniprot.org/uniprot/Q5AF41)<br>_C. glabrata_ CAGL0L06424g: Flocculin type 3 repeat and many other domains | 
| OG5_194847 | 0   | 0    | 1    | 2    | _S. cerevisiae_ _SRL1_: required to stablize cell wall in the presence of multiple GPI-anchored mannoproteins [UniProt](https://www.uniprot.org/uniprot/Q08673) | 

_Notes_

1. Defying my naive expectation that a cytosolic enzyme such as alcohol dehydrogenase can have nothing to do with adhesion, I found [this review](https://mmbr.asm.org/content/72/3/495) and a [paper](https://pubmed.ncbi.nlm.nih.gov/11700367/) it cited that says otherwise. Below I quote from the Discussion section of the second paper:
    > The possibility that a cell-surface-associated cytosolic enzyme could serve in the capacity of an ECM protein receptor andor adhesin is well accepted in other micro- organisms. For example, E. histolytica ADH binds fibronectin, collagen type II and laminin (Yang et al., 1994). Along similar lines, the fibronectin receptor of Streptococcus pyogenes has been shown to be a glyceraldehyde-3-phosphate dehydrogenase (GAPDH) (Pancholi & Fischetti, 1992). Furthermore, these cyto- solic enzymes are found on the cell surface. GAPDH is a major protective antigen found on the surface of Schistosoma mansoni (Goudot-Crozel et al., 1989). GAPDH also functions as a surface lectin responsible for flocculation of the yeast Kluyveromyces marxianus (Fernandes et al., 1992). Pertinent to C. albicans it has been shown that the immunodominant C. albicans glycolytic enzyme enolase is found in culture super- natants and on the surface of the fungus (Sundstrom & Aliaga, 1994), and the cytosolic enzyme 3-phos- phoglycerate kinase is located on the surface of the fungus (Alloush et al., 1997). GAPDH of C. albicans is cell-wall-associated and even binds fibronectin and laminin (Gozalbo et al., 1998). These examples of cytosolic enzymes performing in different capacities are perhaps examples of gene sharing, a concept best demonstrated in the vertebrate cornea and lens where the enzyme ADH serves as a major structural protein with little or no enzymic activity (Cooper et al., 1993).

### FaaPred (FungalRV Score > 0)
Redundant groups with above are not repeated below

| Group_id   | Caur| Calb | Cgla | Scer | Putative function (based on Conserved Domain Database unless noted) | 
|------------|-----|------|------|------|---------------------------------------------------------------------| 
| OG5_127576 | 1   | 2    | 0    | 1    | CAP (Cysteine-rich secretory protein);<br>_C. albicans_ XP_715019.1: Cell wall protein involved in cell wall integrity and which plays a role in virulence. [UniProt](https://www.uniprot.org/uniprot/Q59ZX3) |
| OG5_134514 | 1   | 1    | 1    | 1    | _C. albicans_ _UTR2_: Hevein or type 1 chitin binding domain, glycosyl hydrolase, etc.<br>Extracellular glycosidase which plays an important role in fungal pathogenesis. Involved in cell wall assembly and regeneration, filamentation, and adherence to host cells. [UniProt](https://www.uniprot.org/uniprot/Q59ZX://www.uniprot.org/uniprot/Q5AJC0) |
| OG5_136970 | 0<sup><em>1</em></sup> | 1    | 2    | 1    | _C. albicans_ _KRE9_: S/T-rich GPI anchored, cell-wall biogenesis |
| OG5_138681 | 1   | 1    | 1    | 1    | _C. albicans_ _SCW11_: glycosyl hydrolase |
| OG5_138848 | 2   | 1    | 0    | 0    | _C. albicans_ _RHD3_: GPI anchored, cell wall protein |
| OG5_139398 | 0   | 1    | 1    | 1    | _C. albicans_ _WSC4_: WCS domain, may be involved in carbohydrate binding, present in yeast cell wall integrity and stress response components. |
| OG5_140009 | 0   | 1    | 0    | 2    | _C. albicans_ _WSC4_: WCS domain, may be involved in carbohydrate binding, present in yeast cell wall integrity and stress response components. |
| OG5_149913 | 2   | 1    | 0    | 0    | _C. albicans_ _CSA1_: fungal specific cysteine rich domain, GPI-anchor, heme binding [UniProt](https://www.uniprot.org/uniprot/G1UB63) |
| OG5_155971 | 1   | 1    | 1    | 0    | _C. albicans_ _SIM1_: similar to OG5_136169, beta-glucosidase, SUN family |
| OG5_157055 | 2   | 1    | 0    | 0    | _C. albicans_ _YWP1_: flocculin type 3 repeat, same domain found in the FLO9 in _S. cerevisiae_, close to its C-terminus<br>_CaYWP1_: Cell wall protein which plays an anti-adhesive role and promotes dispersal of yeast forms, which allows the organism to seek new sites for colonization; GPI-anchored [UniProt](https://www.uniprot.org/uniprot/Q59Y31) |
| OG5_176483 | 0   | 0    | 3    | 0    | _C. glabrata_ specific, hyphally regulated cell wall protein N-terminal |

1. There are two _C. auris_ proteins belonging to the same orthogroup as the _C. albicans_ _KRE9_ in OrthoMCL-DB v6, one of which passes the stringent FungalRV threshold but was not predicted by FaaPred, while the other one is not predicted by either.

* [Table of Contents](#table-of-contents)
## 2020-06-13 [HB] Next step
1. Analyze OrthoMCL-DB v6 and check if the results are consistent with v5
1. With the v6r1 data, which includes _C. auris_, could we recover more _C. auris_ genes?
1. Build gene trees for the proteins in the most populated orthogroups
