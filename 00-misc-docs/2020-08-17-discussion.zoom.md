---
title: Zoom discussion 11
author: Bin He
date: 2020-08-17
---

# Summary
Bin and Lindsey presented their main findings from the case study.
- In Bin's protein family study, he found
    - The N-terminal domain belongs to the PFam family, PF11765, which is almost entirely in fungi. A few hits in the alpha-proteobacteria come up in the PFam website and in HMMER searches. Unclear how to interpret them
    - BLASTp search using the N-terminal 350 amino acids from XP_028889033 against the non-redundant protein database on NCBI, with taxonomy restricted to eubacteria (taxid: 0002), yielded one good hit in _Pseudomonas syringae_. Despite the reasonably good alignment -- >50% identity and ~80% positive rate, I found the result untrustworthy because the match is to a partial CDS despite the presence of well assembled _P. syringae_ genomes, and subsequent blast using this partial cds as query against the bacteria in general or _P. syringae_ in particular yielded none other than the query itself.
    - The protein family in Saccharomycotales have expanded most significantly in the MDR clade that contains _C. auris_ and also in the tri-species clade that contains _C. albicans_ (named Iff family in _C. albicans_). The family seems to have been entirely lost in many well studied fungal genomes, such as _S. cerevisiae_ and close relatives.
    - Looking at the rest of the protein excluding the N-terminal domain, Bin found that a S/T-rich region is present in almost all the members. So are the predicted signal peptide at the N-terminus and the GPI-anchor sequence at the C-terminus, suggesting that most of the members in this family are cell-wall proteins, potentially with a stalk that help them protrude to the outerspace (depending on the length of the protein).
    - Beta aggregation sequences require further work. See below.

- In Lindsey's structural analysis, she found
    - Structurally, XP_028889033's NTD doesn't resemble the well-studied Als family from _C. albicans_.
    - The Hyp_reg_CWP region of XP_028889033 structurally resemble the binding region of the bacterial SRRP (Serine-Rich Repeat Protein) adhesin family, which features a $Beta$-solenoid fold. These results are based on I-TASSER threading.
    - I-TASSER chose the same template for another homolog of XP_028889033 from the MDR clade, but decided on a different one (also a bacterial adhesin) for _C.albicans_ Iff4, a member of the Iff family with a suggested role in adhesion.
 
- Combining the two findings, here is Bin's hypotheses
    - $H_1$: the Hyg_reg_CWP domain is _fungal specific_. the similarity in structure between its members and various bacterial adhesins is a result of convergent evolution;
    - $H_2$: this domain is present in the common ancestor of cellular life; however, while selection maintained its structure (hence function), compensatory mutations were allowed to accumulate to the point where no similiarity can be observed at the primary sequence level;
    - moreover, _not all members_ in this family are adhesins. studies in the _C. albicans_ Iff family demonstrated that some of its members are either buried in the cell wall or secreted outside the cell. the former could act as enzymes to remodel the fungal cell wall in the presence of stress, while the latter could play defense or scavange roles.
    - consistent with the above, while nearly all members of the family have GPI-anchor and signal peptide, some are much shorter, less than 1000 residues, and don't have features such as Ser/Thr-rich regions or $beta$-aggregation sequences, indicating that they may play different cellular roles.
    - this protein family is certainly ancient within the Saccharomycetales yeast; however, it has been largely lost in the Saccharomycetaceae family, which includes _S. cerevisiae_, with the exception of the Nakaseomyces group, _N. castellii_ and _K. lactis_. on the other hand, this family has experienced significant expansion in the MDR clade of the Clavipora genus, and also in the clade containing _C. albicans_, _C. tropicalis_ and _C. dubliniensis_.
    - along the line of evolutionary expansion, the rest of the protein sequence excluding the N-terminal domain appear to be fast-evolving. its length and presence of short repeats, especially the TANGO predicted $beta$-aggregation sequences are extremely dynamic during evolution. my (bin's) current model is that the NTD is ancient and has experienced repeated expansion and contraction during evolution. whatever its functions are, it seems it is most useful when anchored on the cell wall (hence Cell-Wall-Protein in the domain name). the diversification of the homologs' function may primarily be determined by the C-terminal sequences. Ser/Thr-rich region allows for O-glycosylation, which leads to a rigid stalk. combined with many repeats, this stalk elevates the NTD above the cell wall matrix, potentially fulfilling the adhesin functions.

# Todo and next meeting topic
- [ ] Seperately plot Ser and Thr frequencies -- Jan observed in her manual annotation differences in the distribution of the two types of residues.
- [ ] Find a way to visualize the periodicity of the GVVIVTT and other similar short sequences identified by TANGO. do this separately from clustering the words.
- [ ] Turn the S/T frequency and $beta$-aggregation sequence plots into a domain architecture schematic, by adding signal peptide, N-terminal Pfam domain and C-terminal predicted GPI-anchor.
    - [ ] collect sequence feature maps for the above and store as a data frame
    - [ ] figure out a way to combine these elements on the same plot
- [ ] Cluster TANGO sequences. Idea: just use local pairwise alignment algorithms and take its total score as a measure of distance. This way I can pick substitution and gap opening penalties and tweak them until I feel comfortable with the outcome.

- [ ] Is the choice of two different templates a result of the structural distinction between CaIff4 and the two MDR clade homologs, or is it a result of some sort of built-in stochasticity because I-TASSER couldn't afford to thread the primary sequence through ALL possible model pipes?
    - [ ] ask I-TASSER to thread each of the three query sequence through the two respective model and compare their quality
    - [ ] examine the I-TASSER output. could it be that the two templates were both identified, just their ranks swapped for the different input?
Next meeting will be next Monday, when the Lindsey and Bin will summarize their major findings so far, focused on the case study.

