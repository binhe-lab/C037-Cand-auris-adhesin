## Background

At the suggestion of a reviewer, we used [GARD](https://academic.oup.com/mbe/article/23/10/1891/1096946) (part of the [HYPHY](https://github.com/veg/hyphy) package) to detect recombination as a pre-step for the PAML analysis. GARD is installed via conda (v2.5.2)

## Method

Analyses were performed on the [datamonkey server](https://datamonkey.org/), with the aligned nucleotide or amino acid sequences for the PF11765 domain in Hil1-8 in _C. auris_ as input.

## Results

### Overview

I tested both amino acid and nucleotide sequence as input. For nucleotide sequence, I tested the default setting with no rate-variation and a scenario allowing for rate-variation following a beta-gamma distribution with four classes. In summary, GARD found strong evidence for recombination in all three analyses, but the inferred number and locations of the breakpoints vary.

| Run type   | Rate variation        | Breakpoints                           |
| ---------- | --------------------- | ------------------------------------- |
| Amino acid | No                    | 28, 101, 230 (nucl: 84, 303, 690)     |
| Nucleotide | No                    | 54, 73, 357, 676, 699, 880            |
| Nucleotide | beta-gamma, 4 classes | 29, 357, 425, 678, 698, 737, 881, 975 |

Overall I conclude that

1. there is evidence of recombination.
2. one breakpoint appears to be robustly inferred, which is located at around 690-700th column in the nucleotide alignment, corresponding to the 230th column in the amino acid alignment.

Based on the above I plan to separate the alignment into two putative non-recombining segments, one from column 1 - 699 and the other from 700 - end. Slight variations in the choice of the breakpoint is not expected to affect the downstream analyses. I will infer a gene tree for each fragment separately and conduct PAML analysis on each.

### Visualization

I tried to find legends explaining what the difference is between the gray, small dots and red large dots, but couldn't. It relates to a parameter named "span", which I can't find documentation for. Nonetheless, it seems the red ones are more "important".

#### Amino acid input, no rate variation

![](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-aa-no-rate-var-breakpoint-by-model.svg)

![](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-aa-no-rate-var-breakpoint-support.svg)

#### Nucleotide input, no rate variation

![20220628-nuc-no-rate-var-breakpoint-by-model](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-nuc-no-rate-var-breakpoint-by-model.svg)

![20220628-nuc-no-rate-var-breakpoint-support](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-nuc-no-rate-var-breakpoint-support.svg)

#### Nucleotide input, beta-gamma distribution, 4 classes

![20220628-nuc-betagamma-4class-breakpoint-support](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-nuc-betagamma-4class-breakpoint-support.svg)

![20220628-nuc-betagamma-4class-breakpoint-by-model](/Users/bhe2/Documents/work/current/C037-Cand-auris-adhesin/02-case-studies/09-natural-selection/output/gard/20220628-nuc-betagamma-4class-breakpoint-by-model.svg)
