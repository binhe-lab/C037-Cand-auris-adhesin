---
title: Zoom discussion 6
author: Bin He
date: 2020-07-13
---

# Summary
- Rachel started to run many of the analyses we intially ran only for _C. albicans_, _C. auris_ and _C. glabrata_ in more species.
- Rachel also dug deeper into the TANGO results and summarized all the short sequences identified by the program per protein, and organized them into total occurences per species (for the entire proteome).
    - looked closely at one of them corresponding to the "GVVIVTT" motif Jan identified earlier, and summarized the number of occurences of it in the different species.
- Jan went through many publications to establish known facts about beta-aggregation -- one instance of a short sequence motif is probably not enough. Multiple occurences could be important. Also, the distance between adjacent motifs could be important -- based on a spider silk study, the 127 aa interval allows for alpha-helices while the shorter 27 aa intervals primarily encode beta-sheets (if I remember Jan's presentation correctly), and that may directly impact the shape and property of the silk produced. Similar ideas can be pursued with the adhesins.

# Todo and next meeting topic
1. Look more closely at the TANGO identified motifs. Instead of simply counting ALL occurences in a proteome, filter the proteome for proteins containing more than X (arbitrary threshold) occurences of the motif (a specific one? or just sum of any identified by TANGO) and relook at the sum across species. Is the higher number in _C. auris_ surprising? Is it due to the expansion of a few gene families? Control for amino acid composition biases across the proteomes?
1. A fine dissection of the C-teminal regions of the case study -- how many instances of the motif does each protein have, what's the major interval? Do those properties follow the gene tree structure, which would suggest similarity by inheritance?
1. Look at O-glycosylation and N-glycosylation statistics using programs.
1. Learn how to perform PCA -- first decide the columns (properties, summarized to a number), and then learn how to properly weight them in the PCA. Also check for independence among columns?
1. [HB] A realistic goal is to learn a lot more about the homologs of XP_028889033 -- are the homologs all predicted to be adhesins? Do they share the low complexity repeats and the beta-aggregation motifs in them? are their C-terminal regions rich in S/T?

scheduled for the Monday after next week, 20th July, 3:30-4:30 pm
