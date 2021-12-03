# Motivation & Goal
This analysis is suggested by John McCutcheon, who visited our department this semester. When I described the correlation between the size of the Hil family and the pathogenic potential of the species, he questioned whether the deviation from the phylogenetic relationship is by chance. He suggested using Matthew Hahn's lab's [CAFE](https://hahnlab.github.io/CAFE) to test it formally. CAFE explicitly models the evolution of gene families using a birth-and-death process. It takes as input a species tree with branch length and a gene family size table, and tests whether a uniform pair of gain/loss rates is sufficient to explain the family size distribution using a log likelihood-ratio test. 

# Approach
## Species tree
To do this test, I need to first obtain a species tree with branch lengths. It turns out that so far the species tree is only a cladogram and is based mostly upon the Shen et al 2018 Cell paper, with one change based on the Munoz 2018 Nat Comm, where _D. hansenii_ is placed as being more closely related to the Clavispora genus than with the Candida genus. This change was made because our PF11765 domain tree also supported the latter topology, plus the placement of _D. hansenii_ was one of the uncertain ones in the Shen et al 2018 paper. It is worth noting that the Munoz 2018 tree was inferred from the concatenated alignments of 1570 single-copy genes, and not just cobbled together based on prior literature. In order to obtain a phylogram with branch lengths, I thought about extracting a subtree ("pruning") from the 332 taxa tree in the Shen et al 2018, leaving out _D. hansenii_. To do so, I emailed Antonis Rokas, whose lab led this work. Antonis and his student Jacob Steenwyk pointed me to a software named Treehouse they wrote exactly for this purpose: to extract a subtree from a large phylogeny. So in this analysis I'm going to follow their [instructions](https://github.com/JLSteenwyk/treehouse)

- Downloaded the time-calibrated newick tree for the 322 taxa from the [figshare depository](https://figshare.com/articles/dataset/Tempo_and_mode_of_genome_evolution_in_the_budding_yeast_subphylum/5854692) for the Shen et al 2018 paper, `data_in_Figure2.zip`. Unzip the file and copy the `332_2408OGs_time-calibrated_phylogeny.tre` to `input` folder.
- Wrote the `input/species-list.txt` to define the species for extracting. Note that the 322 taxa tree doesn't include any of the species in the MDR clade except for _C. auris_. So unfortunately we cannot include them. I also removed _D. hansenii_ (see above).
- Used the Treehouse shinyapp to extract the subtree and save as `input/20211202-pruned-subtree-treehouse.nwk`
- Edited the tree to 1) shorten the species name (CAFE doesn't recognize "_" in taxa names...) and 2) convert the divergence time by multiplying each value by 100 - I inferred that the values are in MYA units - and CAFE manual says the divergence time has to be integers, although the tree has also to be ultrametric, so I kept all the digits.
- Wrote the `input/gene-families-input.txt` file based on Fig 1 of our paper.

## Run CAFE
See the script files in the `script` folders. Primarily based on the manual and the tutorial on CAFE website.

## Analyze output
See `analysis/README.Rmd`

# Results
Neither the family-wide p-value nor the multi-lambda vs global lambda test turned out significant. Looking at the simulated dataset, it is apparent that under the stochastic birth and death model, it is likely to get family expansions and contractions to look like what we observed. However, CAFE only tests for significant rate differences in family size evolution, without any consideration for convergence -- in our case the two clades showing gains are not random but are both pathogenic. While this could still be coincidence, I think the amount of evidence is stronger than what CAFE analysis would suggest without taking the pathogenic status into account.
