# Motivation & Goal
This analysis is suggested by John McCutcheon, who visited our department this semester. When I described the correlation between the size of the Hil family and the pathogenic potential of the species, he questioned whether the deviation from the phylogenetic relationship is by chance. He suggested using Matthew Hahn's lab's [CAFE](https://hahnlab.github.io/CAFE) to test it formally. CAFE explicitly models the evolution of gene families using a birth-and-death process. It takes as input a species tree with branch length and a gene family size table, and tests whether a uniform pair of gain/loss rates is sufficient to explain the family size distribution using a log likelihood-ratio test. 

**Update 2022-08-17**
While reading Zarin et al 2017 (PMID: 28167781) for a different project (evolution of IDR in Pho4), I encountered the some reference on the phylogenetic comparative methods. Some searches later, I landed on Levy et al. 2017 (PMID: 29255260), which asked a similar question in their study as we are asking here: is there a correlation between the number of genes in a category/family and the life history of a species. In their case, the species are all bacteria and the life history trait is whether the bacteria is plant associated. Instead of testing a single gene family, they looked at tens of thousands of orthogroups. But the basic idea is the same. They performed three kinds of statistical tests, two of which will be tried here. Their first test is a hypergeometric test, which asks whether the proportion of genes within an orthogroup out of all genes in an species differ between the two groups of species, namely plant-associated and non-plant-associated. Here we will use a simpler test without accounting for the total number of genes in each species (implicitly assuming they are the same), and perform a t-test or rank-order-test to examine the statistical evidence for a significance difference in the mean number of genes in the Hil family between the pathogenic vs non-pathogenic lineages. Note that this test incorrectly assumes the random variable representing the number of Hil genes in each species are independently and identically distributed. In the second approach, Levy et al used the phylogenetic linear regression, which is similar to the test above (consider the t-test as a one-way ANOVA, with normally distribted residuals), except that the residual has a variance that reflects the phylogenetic relationship between the species. They implemented the test using the [phylolm](https://cran.r-project.org/web/packages/phylolm/index.html) package. Here I will attempt to repeat both. The analysis is documented in `analysis/gene-family-enrichment.Rmd`

# PhyloGLM

## Approach

See `./analysis/phylolm.Rmd` for details. Followed the analysis pipeline in Levy et al. 2017, with commands modified based on their [github repo](https://github.com/isaisg/gfobap/tree/master/enrichment_tests/).

## Results

See `./analysis/phylolm.nb.html`. Briefly, the phylogenetic test showed that there is significant (_P_ < 0.005) association between the Hil family size and the life history trait of being a human pathogen, after accounting for the phylogenetic relatedness. Note that this method assumes the binary trait (pathogen or not in this case) to be the dependent variable and the family size as the independent variable. The natural interpretation, therefore, is that species with a larger Hil family size is more likely to be pathogenic. Also,  while reading the paper behind this method (Ives and Garland, 2010 PMID: 20525617), I realized that the method treats the independent variable as fixed, meaning that it doesn't consider the phylogenetic signal in the independent variable. I'm not entirely clear on how this incorrect assumption (at least in our case) affects the interpretation of the results. But the result does provide stronger support for an association between the Hil family size and the pathogenic potential of a species after at least correcting for the phylogenetic signal in the pathogen state trait.

# CAFE

## Approach

### Species tree
To do this test, I need to first obtain a species tree with branch lengths. It turns out that so far the species tree is only a cladogram and is based mostly upon the Shen et al 2018 Cell paper, with one change based on the Munoz 2018 Nat Comm, where _D. hansenii_ is placed as being more closely related to the Clavispora genus than with the Candida genus. This change was made because our PF11765 domain tree also supported the latter topology, plus the placement of _D. hansenii_ was one of the uncertain ones in the Shen et al 2018 paper. It is worth noting that the Munoz 2018 tree was inferred from the concatenated alignments of 1570 single-copy genes, and not just cobbled together based on prior literature. In order to obtain a phylogram with branch lengths, I thought about extracting a subtree ("pruning") from the 332 taxa tree in the Shen et al 2018, leaving out _D. hansenii_. To do so, I emailed Antonis Rokas, whose lab led this work. Antonis and his student Jacob Steenwyk pointed me to a software named Treehouse they wrote exactly for this purpose: to extract a subtree from a large phylogeny. So in this analysis I'm going to follow their [instructions](https://github.com/JLSteenwyk/treehouse)

- Downloaded the time-calibrated newick tree for the 322 taxa from the [figshare depository](https://figshare.com/articles/dataset/Tempo_and_mode_of_genome_evolution_in_the_budding_yeast_subphylum/5854692) for the Shen et al 2018 paper, `data_in_Figure2.zip`. Unzip the file and copy the `332_2408OGs_time-calibrated_phylogeny.tre` to `input` folder.
- Wrote the `input/species-list.txt` to define the species for extracting. Note that the 322 taxa tree doesn't include any of the species in the MDR clade except for _C. auris_. So unfortunately we cannot include them. I also removed _D. hansenii_ (see above).
- Used the Treehouse shinyapp to extract the subtree and save as `input/20211202-pruned-subtree-treehouse.nwk`
- Edited the tree to 1) shorten the species name (CAFE doesn't recognize "_" in taxa names...) and 2) convert the divergence time by multiplying each value by 100 - I inferred that the values are in MYA units - and CAFE manual says the divergence time has to be integers, although the tree has also to be ultrametric, so I kept all the digits.
- Wrote the `input/gene-families-input.txt` file based on Fig 1 of our paper.

### Run CAFE
See the script files in the `script` folders. Primarily based on the manual and the tutorial on CAFE website.

### Analyze output
See `analysis/README.Rmd`

## Results
Neither the family-wide p-value nor the multi-lambda vs global lambda test turned out significant. Looking at the simulated dataset, it is apparent that under the stochastic birth and death model, it is likely to get family expansions and contractions to look like what we observed. However, CAFE only tests for significant rate differences in family size evolution, without any consideration for convergence -- in our case the two clades showing gains are not random but are both pathogenic. While this could still be coincidence, I think the amount of evidence is stronger than what CAFE analysis would suggest without taking the pathogenic status into account.
