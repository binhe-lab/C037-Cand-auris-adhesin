# Background and Goal
The key question is this: during the expansion and the subsequent divergence of the Hil family in _C. auris_ and other species, what types of selection forces were at play? Was it mostly drift? Purifying selection? Or was positive selection involved? I suspect that the N-terminal PF11765 domain is likely to have evolved under strong purifying selection, while the repeat sequences may have been under relaxed purifying selection or possibly positive selection.

Zhang Yong (张勇) at the CAS Zoology Institute suggested a paper by by Persi, Wolf and Koonin 2016, Nat Comm on testing for selection in repeat regions (there is a term called Variable Number of Tandem Repeats, or VNTR). In this work they developed an analysis pipeline to identify "nearly-perfect" repeats that are highly periodical (identical length) and similar (high information content). This allowed them to align them and estimate the dn/ds ratios. Their study was motivated by the observation that while VNTRs tend to evolve very rapidly, they are sometimes conserved through long spans of evolution. Note that when applied to the entire protein, it reflects the **average selection forces** and since most of times positive selection only affect a small number of amino acids, the average dN/dS is likely to be less than one. When applied to the PRDM9 protein in human as a case study, they identified an extremely high dn/ds ratio, more than 2. This strong signature of positive selection for the divergence  among the repeats fits whatq we know about the protein's function perfectly -- the repeats in PRDM9 encode zinc fingers, each of which recognizes a similar but not identical DNA motif. Together, they form a combinatorial code that determines the binding location of the protein in the genome. As PRDM9 is known to evolve rapidly (see references in that paper) specifically in the DNA sequences they recognize, which is mediated by changes in individual zinc fingers, it makes sense that the repeats would diverge under positive selection (for different binding motifs). This pattern only applies when the individual repeats perform distinct functions (e.g., recognize a unit of the combinatorial DNA supermotif).

The goal here is to replicate the Persi, Wolf and Koonin's approach, which treats the repeats *within a protein* as paralogous copies (since they originated from duplications) and calculate the pairwise dN/dS ratios between them as an indication for the selection forces that has acted on them through the protein's evolutionary history. The same approach can be applied to orthologous pairs. The analysis on the human proteome by the above paper concluded that "horizontal evolution of repeats (repeats within the same protein) is markedly accelerated compared with their divergence from orthologues in closely related species".

A related question to explore is whether after the duplications the N-terminal domains have also functionally diverged (possibly evolving new substrate specificity). This would be reflected in the dN/dS of the NTD on different branches.

# Approach
Note that there are several comparisons we could make:
1. between repeats within the same protein, e.g., Hil1, as described above (horizontal)
1. between in-paralogs, e.g., Hil1 vs Hil2 (in-paralogs) -- if global alignment of the central domain is not possible, use individual repeats
1. between alleles within _C. auris_ for the same protein, e.g. Hil1, for all of its repeats as long as they align (polymorphism)
    Read Sergey's dN/dS for polymorphisms paper
1. between orthologs in closely related species for Hil1 (orthologs)
    Because of the frequent duplications, the most closely related homolog for Hil1, not counting alleles within the species, is actually the in-paralog Hil2.

What we know about the evolutionary history of the Hil family in _C. auris_:
![Hil family gene tree](../07-Cauris-polymorphism/output/figure/20211207-reconciled-NTD-tree-annotated.png)

In some cases, the in-paralogs are more closely related to each other than they are to the most closely related ortholog in related species -- this is the case for Hil1/Hil2, which arose by duplication after _C. auris_ diverged from the other MDR species sampled here. In other cases, the orthologs in the MDR relatives would be more closely related than the in-paralog, such as Hil3/Hil4.

# Notes
## Hil1 TR horizontal repeat evolution
The goal of this subanalysis is to calcualte the pairwise dn/ds ratios between repeats within a protein.

### Collect sequence
The first step is to extract the paralogous repeat alignments, which I already did when making a supplementary figure. With it, I should be able to test various dN/dS calculation functions available [here](https://rdrr.io/rforge/seqinr/man/kaks.html), [here](https://rdrr.io/cran/ape/man/dnds.html) and [here](https://github.com/a1ultima/hpcleap_dnds).

1. Download the nucleotide and amino acid sequences for XP_028889033.1 (B11221 Hil1) from [NCBI](https://www.ncbi.nlm.nih.gov/gene/40029317/)
1. Open the nucleotide sequence in Jalview and translate it using gencode 12 (yeast alternative nuclear). This leads to a split view.
1. Select 541-1906 in the amino acid window. The corresponding nucleotides are selected automatically.
1. Export the selected sequences (both nucleotide and amino acid) as fasta files.
1. In Vim, use regex search and replace to first combine the sequences into one line, with the header deleted.
1. Use `fold -w44 file > out` to reformat the amino acid sequence so that each repeat is on its own line. Replace "44" with "132" for the nucleotide sequence
1. Following this [tip](https://vim.fandom.com/wiki/Insert_line_numbers), add the headers for each repeat sequence using the line numbers.
    `:%s/^/\=printf('Caur_Hil1_tr%-2d|', line('.'))/` and then replace the "|" with a newline character
1. With the nucleotide alignment file, I use either MEGA11 or the `dnds()` function in the `ape` package in R to calculate the pairwise dn/ds ratios.

### PAML analysis
1. Use `pal2nal.pl` to generate a PHYLIP format nucleotide alignment (since the nucleotide sequences are already aligned, this step can also be done with any program that can convert a fasta to a phylip format).
1. PAML author (Yang Ziheng) recommended using `runmode = -2` in PAML to perform pairwise ML analysis to estimate dN/dS ratios, rather than the NG86 estimates. Both were produced in the run. For NG86, many sites cannot be estimated due to saturation. ML produced an estimate for each pairwise comparison.
### Results and discussion

## Hil1,2 orthologs in MDR, PF11765 domain
Goal of this subanalysis is to provide a background omega ratio estimate to be compared with the pairwise dn/ds ratios from the horizontal evolution among the repeats.
### Prepare sequences for the orthologs of Hil1,2 in MDR
I extracted 10 sequences that form a clade in the MDR clade Hil tree, including Hil1 and Hil2 from three strains of _C. auris_ and outgroup sequences from the other MDR species. The protein sequences were extracted from the `input/cauris-four-strains-for-gene-tree-epa.fasta` using `seqtk subseq in.fasta list.txt > out.fasta` command, with the IDs in `input/id-list-extract-fasta.txt`. The corresponding nucleotide sequences were from NCBI by searching the protein ID and then either going for the corresponding RefSeq_RNA record if available, or, if not, use the locus tag (e.g. B9J08_004109) to extract the mRNA feature from the chromosome or scaffold sequence file in the nucleotide database from BCBI.
1. Use `clustalo -i in.fasta -o out.fasta --iter=5` to align the `input/Hil1-2-MDR-full-unaligned.faa`. Inspect the alignment in Jalview.
1. Align the nucleotide sequence based on the amino acid sequence alignment using `pal2nal pep.aln nuc.fasta -output fasta -codontable 12`. (`pal2nal` installed via conda, [link](https://anaconda.org/bioconda/pal2nal))
1. Extract the PF11765 domain portion in Jalview and export to `input/Hil1-2-MDR-NTD-aligned.fXa`
### Infer phylogenetic tree for the NTD sequences
This step is needed to perform the tree-aware ML analysis in PAML (instead of the pairwise estimates). The advantage of this approach is that it leverages all sequence data and the tree to increase the confidence in the estimate. For it to work, however, we need to assume that the omega parameter is the same across the tree, which is reasonable in this case as we are focusing on just the Hil1 and Hil2 part of the tree, where we don't hypothesize there was positive selection for the NTD in any of the lineages.

To infer the tree, I installed [`raxml-ng`](https://github.com/amkozlov/raxml-ng) by downloading the pre-compiled binary for macos. The following command was used for tree inference:
```bash
raxml-ng --msa input/Hil1-2-MDR-NTD-aligned.faa --model LG+G --seed 123 --threads 3 --prefix output/gene-tree/Hil1-2-MDR-NTD/20211227a
```

The resulting tree was rooted in FigTree and exported in Newick format, further edited to remove the single quotes (PAML doesn't like them) and the branch length estimates. The edited tree was copied to the PAML folder.
### Estimate omega ratios using paml
The purpose of the PAML analysis are
1. Estimate omega for the NTD among the selected sequences (assuming a single omega).
1. Test for positive selection (not expected, but would like to test it anyway).

The `codeml.ctl` control file contains all the parameters used. The key ones are:
```
      seqfile = Hil1-2-MDR-NTD-aligned.nuc * sequence data filename
     treefile = raxml-rooted-20211227.nwk  * tree file
      outfile = mcl                        * main result file name

        model = 0
                    * models for codons:
                        * 0:one, 1:b, 2:2 or more dN/dS ratios for branches

      NSsites = 0 1 2 * dN/dS among sites. 0:no variation, 1:neutral, 2:positive
        icode = 8  * 8: yeast alt nuc
```

### Results and interpretation
1. Turns out PAML outputs the NG86 estimates (Jukes-Cantor corrected for multiple hits) of dS and dN in both its main output file and also the individual files of `2NG.dS` and `2NG.dN`. I compared the results to the estimates by MEGA11 using NG (JC corrected). The PAML estimates are slightly higher (~2%).
1. There is no evidence for positive selection -- the site model M2a (three categories of sites: constrained with ω < 1, neutral with ω = 1 and positive with ω > 1) has nearly the same log likelihood score as the neutral M1a model, and the ω estimate for the third category is actually 1, suggesting there is no evidence for positive selection.
1. The overall ω estimate is made by two models. M1a assumes two categories of sites -- those that evolve neutrally and those that evolve under selective constraints -- and this model estimates that 85% of the sites evolve under constraint, with an ω value of 0.06. M0 assumes a single category of sites and it estimates an ω value of 0.108. The reason M0 estimate is higher is because it lumps the neutrally evolving sites into the constrained sites and thus inflates the ω estimate. It is worth noting that the LRT statistic (-2 difference in log likelihood scores between the two models) is ~160 and is highly significant suggesting that M1a is a much better fit. In other words, there is strong evidence of variable selective constraints among sites in the NTD.
## Hil1-8 in _C. auris_ with MDR outgroups
Using the locus tags or pIDs, e.g., B9J08_004109 or PIS50296.1 for Hil1, I can extract the CDS sequences from the [genome file](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/759/435/GCA_002759435.2_Cand_auris_B8441_V2/GCA_002759435.2_Cand_auris_B8441_V2_cds_from_genomic.fna.gz) using Vim (if more sequences need to be extracted, can automate using either bioawk or [seqkit](https://www.biostars.org/p/318979/)).
