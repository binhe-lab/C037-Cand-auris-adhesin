## Hil1-4-repeat 
B11221/B8441 Hil1-4 repeat pairwise estimates using ML or YN00 |

| directory | content |
|-----------|---------|
| B11221-Hil1-repeat-ml       | B11221 Hil repeats pairwise estimates using ML analysis |
| B11221-Hil1-repeat-yn00     | B11221 Hil repeats pairwise estimates using YN00 algorithm |
| B8441-Hil1-2-repeat-yn00    | B8441 Hil1 and Hil2 repeats pairwise estimates using YN00 algorithm |
| B8441-Hil1-repeat-yn00      | B8441 Hil1 repeats pairwise estimates using YN00 algorithm |
| B8441-Hil3-repeat-yn00      | B8441 Hil3 repeats pairwise estimates using YN00 algorithm |
| B8441-Hil4-repeat-yn00      | B8441 Hil4 repeats pairwise estimates using YN00 algorithm |

## Hil1-2-MDR
Pairwise estimates using YN00 for the Hil1-2 clade, including MDR relatives, for either the PF11765 domain or the tandem repeat region. To be used for comparison with the pairwise estimates for the repeats above.

| directory | content |
|-----------|---------|
| Hil1-2-MDR-NTD-site | full ML analysis to estimate omega on Hil1-2 part of the tree |
| Hil1-2-MDR-PF11765-yn00 | pairwise estimates between the Hil1 and Hil2 homologs with closely related MDR seqs, for the PF11765 domain or the tandem repeat region |
| Hil1-2-MDR-tr(cleaned)yn00  | pairwise estimates between the Hil1 and Hil2 homologs with closely related MDR seqs for the tandem repeat region (cleaned: alignment curated with BMGE) |

## MDR-PF11765
Full MDR PF11765 tree ML analysis

| directory | content |
|-----------|---------|
| MDR-PF11765-freeR           | MDR homologs PF11765 domain, model=1, NSsites=0 |
| MDR-PF11765-oneR            | MDR homologs PF11765 domain, model=0, NSsites=0 |

## b8441-hil1-8-pf11765
main ml analysis for the _c. auris_ hil1-8 pf11765 domain alignment, using various models.

the subdirectories are first grouped by the `codonfreq = 0/1/2` parameter. the branch models are labeled as `1/2/3r` and the site model is labeled as `site`

| directory | parameters | description |
|-----------|---------|----------|
| codonfreq0-freer  | codonfreq=0, model=1, nssites=0 | free omega |
| codonfreq0-1R  | CodonFreq=0, model=0, NSsites=0 | one omega |
| codonfreq0-2Ra | CodonFreq=0, model=2, NSsites=0 | two omega with Hil6/8 ancestor different from the rest |
| codonfreq0-2Rb | CodonFreq=0, model=2, NSsites=0 | two omega with Hil1/2/6/8 ancestor different from the rest |
| codonfreq0-2Rc | CodonFreq=0, model=2, NSsites=0 | two omega with Hil6/8 ancestor AND Hil1/2/6/8 ancestor equal to each other and different from the background |
| codonfreq0-2Rap | CodonFreq=0, model=2, NSsites=0, fix_omega=1, omega=1 | two omega with Hil6/8 ancestor constrained to be 1 |
| codonfreq0-site | CodonFreq=0, model=0, NSsites=0 1 2 7 8 | Site model test |
| codonfreq0-siteM8a | CodonFreq=0, model=0, NSsites=8, fix_omega=1, omega=1 | Site model M8a |

## B8441-OG-part
Updated 2022-07-03: in response to reviewer's comment, we used GARD and detected evidence of recombination in the PF11765 domain alignment. Here we split the alignment into putative non-recombining segments. For each segment, we will perform the site tests and branch tests. The results will be organized by the test parameters.

the subdirectories are first grouped by the partitions, then by the separate tests performed. This time I used a ipython notebook to organize all the PAML analyses, including setting up and running the program, then loading and analyzing the results.

The nucleotide alignment files are directly linked from the `input/homologs` folder, while the gene trees are copied from `input/gene-tree/` folder, with branch lengths removed. Additional gene tree files are modified based on thefirst one (e.g., `p1-414.nwk`)
