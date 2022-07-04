# Overview

## Question

The key question is this: during the expansion and the subsequent divergence of the Hil family in _C. auris_ and other species, what types of selection forces were at play? Was it mostly drift? Purifying selection? Or was positive selection involved? We will split the analysis into two parts, first on the N-terminal PF11765 domain, whose sequence is far more conserved and alignable across the entire Hil family (that's by definition, as we identified Hil homologs by the PF11765 domain), and second on the repeat-rich central domain, which is only alignable between recently diverged/duplicated members. For the PF11765 domain, we expect the majority of the sites to evolve under strong purifying selection. We would like to determine, however, if during the expansion of the family in _C. auris_ specifically, there have been periods of relaxed selection or even episodes of positive selection involved. For the repeat-rich central domain, our primary focus is on the evolution of the individual repeat units. Since they arose through duplications, one can treat them as "paralogs" and ask what selection forces were at play. In this scenario, the host proteins act somewhat like "species", in that we can identify repeats that existed in the ancestral protein (=ancestral species) vs those that were duplicated after the gene duplication. This can be inferred based on the phylogeny of the repeats. On top of that tree of the repeats, one can further estimate the dN/dS ratios and use the [phylogenetic independent contrast](https://en.wikipedia.org/wiki/Phylogenetic_comparative_methods#Phylogenetically_independent_contrasts) to extract statistically independent measures. The main question is whether there was any sharp difference in the selective pressure right after the gene duplication (akin to speciation) event.

## Background

The idea for studying the selective pressures especially on the repeat region came from Zhang Yong (张勇) at the CAS Zoology Institute, who suggested a paper by by Persi, Wolf and Koonin 2016, Nat Comm on testing for selection in repeat regions (there is a term called Variable Number of Tandem Repeats, or VNTR). In this work they developed an analysis pipeline to identify "nearly-perfect" repeats that are highly periodical (identical length) and similar (high information content). This allowed them to align them and estimate the dn/ds ratios. Their study was motivated by the observation that while VNTRs tend to evolve very rapidly, they are sometimes conserved through long spans of evolution. Note that when applied to the entire protein, it reflects the **average selection forces** and since most of times positive selection only affect a small number of amino acids, the average dN/dS is likely to be less than one. When applied to the PRDM9 protein in human as a case study, they identified an extremely high dn/ds ratio, more than 2. This strong signature of positive selection for the divergence  among the repeats fits whatq we know about the protein's function perfectly -- the repeats in PRDM9 encode zinc fingers, each of which recognizes a similar but not identical DNA motif. Together, they form a combinatorial code that determines the binding location of the protein in the genome. As PRDM9 is known to evolve rapidly (see references in that paper) specifically in the DNA sequences they recognize, which is mediated by changes in individual zinc fingers, it makes sense that the repeats would diverge under positive selection (for different binding motifs). This pattern only applies when the individual repeats perform distinct functions (e.g., recognize a unit of the combinatorial DNA supermotif).

The goal here is to replicate the Persi, Wolf and Koonin's approach, which treats the repeats *within a protein* as paralogous copies (since they originated from duplications) and calculate the pairwise dN/dS ratios between them as an indication for the selection forces that has acted on them through the protein's evolutionary history. The same approach can be applied to orthologous pairs. The analysis on the human proteome by the above paper concluded that "horizontal evolution of repeats (repeats within the same protein) is markedly accelerated compared with their divergence from orthologues in closely related species".

## Update

One reviewer from Review Commons raised the issue of potential recombination within the PF11765 domain. If true, the region cannot be described by a single phylogeny and thus the previous PAML analysis assuming a single phylogeny could lead to false positive or false negative results. The solution suggested by the reviewer was to run [GARD](https://datamonkey.org) to detect evidence for recombination. If recombination is detected, GARD also infers the most likely breakpoints, which would allow the researcher to split the original alignment into putatively "non-recombining segments", which can be used for downstream analyses.

See [here](TR-evolve-notes.md) for notes on the original analysis.

# Analyses

## PF11765 domain

### GARD analysis

See [here](output/gard/README.md) for detailed notes on the analysis. The basic conclusion is that GARD did find evidence for recombination. However, the breakpoints inferred differred both in number and locations depending on whether the nucleotide or amino acid alignment was used as input and what rate variation parameters were chosen. I decided to pick the breakpoint that was most consistently detected across the several models tested. This involves splitting the original alignment into two segments, one from column 1 to 699 and the second from 700-end. The next steps are

1. separately infer the phylogenetic tree for each segment.
2. use the segment alignment and tree as input for PAML analysis.
3. summarize the PAML results and compare them to the original single segment analysis result.

### Prepare alignment

In order to split the alignment into partitions based on custom boundaries, I made several changes to the previous workflow:

- added XP_018709340.1 from _M bicuspidata_ to the alignment to serve as an outgroup.
- renamed Hil1-8 from _C. auris_ to just be Hil1 through Hil8. This makes it easier to work with the sequence names in various format conversions (especially when it involves PHYLIP format).
- instead of using `pal2nal.pl` to convert the codon alignment into PHYLIP format, I wrote a [custom script](script/split-alignment.py) to partition the alignment based on the boundary information stored in a text file. In writing this script, I learned a lot of useful things about the Biopython's AlignIO module. See this helpful [tutorial](http://biopython.org/DIST/docs/tutorial/Tutorial.html#sec80).

## Previous results on PF11765 domain evolution
The question here is whether after the duplications that led to Hil1-8 in _C. auris_, there has been selection on the PF11765 domain to diversify in its function among the paralogs. So far I've been describing the evolution of the NTD as being conserved. While this is true relative to the fast-evolving repeat regions, it ignored the possibility of positive selection acting on the backdrop of purifying selection in the background (for most of the sites). After all, if positive selection was indeed involved, it would have only acted on a few residues.

I have two specific questions here:

1. Assuming equal selective forces on all branches (for Hil1-8), can the site-model detect fast evolution for certain sites within PF11765?
1. Assuming equal selective constraints on all sites, can we detect certain branches with elevated dN/dS (omega) over the background, which would suggest episodes of relaxed constraints or positive selection?

### Branch model

I wrote several scripts in the `script` folder to extract, align and transform the coding sequences for Hil1-8 for PAML analysis. I also used the `ape` package's `drop.tip()` function to prune the GeneRax corrected gene tree for the MDR homologs for use with PAML analysis. For PAML, the important parameters used are

```
      seqtype = 1  * 1:codons; 2:AAs; 3:codons-->AAs
    CodonFreq = 1  * 0:1/61 each, 1:F1X4, 2:F3X4, 3:codon table
        clock = 0   * 0: no clock, unrooted tree, 1: clock, rooted tree
        model = 1
                    * models for codons:
                        * 0:one, 1:b, 2:2 or more dN/dS ratios for branches

      NSsites = 0  * dN/dS among sites. 0:no variation, 1:neutral, 2:positive
        icode = 8  * 8: yeast alt nuc

    fix_kappa = 0  * 1: kappa fixed, 0: kappa to be estimated
        kappa = 2  * initial or fixed kappa
    fix_omega = 0  * 1: omega or omega_1 fixed, 0: estimate 
        omega = .4 * initial or fixed omega, for codons or codon-based AAs

        getSE = 1  * 0: don't want them, 1: want S.E.s of estimates

   Small_Diff = .5e-6
    cleandata = 0  * remove sites with ambiguity data (1:yes, 0:no)?
  fix_blength = 0  * 0: ignore, -1: random, 1: initial, 2: fixed
```

- The `model` parameter is varied between 0, 1 and 2 depending on the analysis (one dN/dS ratio across the tree, free ratios vs multiple ratios as defined in the tree).
- The `CodonFreq` parameter was originally left out and I found that the default was 0, i.e. equal frequency. To explore the robustness of the result, I changed this to 1 or 2 and repeated the analysis. The results suggest that for the Hil1-8 dataset, `CodonFreq = 2` results in very large dS estimates for some branches and a transition/transversion ratio of ~1.2, which is much lower than the 1.7-2.3 that I've been getting with `CodonFreq = 0 / 1` and the pairwise analysis. Some branches identified as having dramatically elevated dN/dS with `CodonFreq = 2` differed from those identified under the other two situations. But one branch was consistently identified as having much higher dN/dS than the rest.
- `clock=0` is the default if the line is commented out.

Initially I planned to work with the 35 sequences in the MDR clade tree as shown above. But I found an exploratory run with the one ratio and free ratio model with the large dataset, I found the patterns are quite complicated. In particular, several non auris MDR species homologs show elevated dN/dS. Since the next step is to test hypotheses about specific branches being subject to positive selection, this large dataset provides too many clues that are not focused on _C. auris_, our focal species.

![MDR PF11765 domain free ratio estimates](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/figure/20220122-MDR-PF11765-freeR-anno-tree.png)

Based on the above, I decided to switch to a small dataset with just Hil1-8 from _C. auris_. The goal is to specifically ask whether during the expansion of the Hil family in _C. auris_ any of the duplicated copies experienced accelerated evolution in their NTD, which could be indications of either relaxed constraints (if ω is higher than the background but lower than 1) or positive selection (if ω > 1). My approach is to first run the free ratio model to identify candidate branches that are likely to have had elevated dN/dS. Note that this approach violates the best practice in statistical testing. Here is a quote from Yang 1998 (PMID: 9580986):

> Strictly speaking, a proper statistical test requires the null hypothesis to be specified before the data are analyzed. ... While the lack of independence of the hypothesis on data is not expected to have a great effect, it does increase the probability of rejecting the null hypothesis.

I will note these while writing up this part.

That said, using the free ratio model (model = 1), I found `CodonFreq = 0/1` led to the same picture: the ancestral branch of Hil6/8 and the ancestral branch of Hil1/2/6/8 were inferred to have an extreme dN/dS, since their dS estimates are 0.

![cauris Hil1-8 Fequal freeR](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/figure/20220122-caur-PF11765-Feual-freeR-anno-tree.png)

Based on this result, I set up a series of tests (in the `output/paml/B8441-Hil1-8-PF11765` folder) and summarized the results in a [google sheet](https://docs.google.com/spreadsheets/d/1iufv2kxs1tuUXiOvHX1CGbYaFmCWnCXX-AHUnXRgjlk/edit?usp=sharing).

### Site model

The site model is to detect particular sites under positive selection. Based on PAML's manual and Ziheng Yang's papers (e.g. Yang et al 2000, PMID: 10790415), I ran `NSsites = 0 1 2 7 8`, where the comparisons of interests are M1a vs M2a (1 vs 2) and M7 vs M8 (7 vs 8). According to the manual, the first comparison is more stringent than the second one. M1a specifies two categories of sites, with `omega_0 < 1` (constrained) and `omega_1 = 1` (neutral); M2a has one more class than M1a, i.e. `omega_2 > 1`. M7 and M8 are similar to M1a and M2a except that a beta distribution was used to model the constrained and neutral class, with two parameters for the beta distribution (p, q). A third test compares M8 with M8a, where M8a is specified with `NSsites = 8, fix_omega = 1, omega = 1`. This modified test specifically asks whether there is evidence for positive selection on the selected branch, by constraining the foreground branch's dN/dS as 1 in the null model.

I again ran the tests under the three `CodonFreq` options (0, 1, 2). In all three cases, the M1a vs M2a comparison turned out insignificant (the LL scores are nearly identical), while the M7 vs M8 comparison was highly significant (chi^2 test p-values < 0.001). So are the M8 vs M8a comparisons. A serine residue in column 261 in the alignment was consistently identified as under strong positive selection.
