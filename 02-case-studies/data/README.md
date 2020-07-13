## Content
File | Description | Source | User/Date
-----|-------------|--------|----------
XP_028889033.1_homologs.fasta | Homologs for Lindsey's protein, including alleles from the five _C. auris_ strains | BLAST identified | LFS/2019
XP_028889033.1_homologs_edited_names.fasta | Same as above except only B8441 strain is included for _C. auris_, and the sequence names were standardized | Same as above | LFS/2020 
XP_028889033.1_homologs_table.tsv | Table showing the homologs of the query protein identified by BLAST | fungiDB | LFS/2019
XP_028892406_homologs.fasta | Homologs for Rachel's protein | BLAST identified | RS/2019.12
Species_Tree_Seq.fasta | Concatednate single gene family sequences to infer species relationship | See notes below | LFS/2020
speciestree | Species tree inferred from the sequences above | See notes below | LFS/2020
XP_028889033_homologs_combine.fasta | Homologs for Lindsey's protein, based on blast against fungiDB AND refseq_protein | BLAST identified | HB/2020
20200709-species-tree.nwk | Species tree for the species included in the above file | Manually written based on the tree from Shen et al 2018 Cell | HB/2020

## Notes
### 2020-07-xx [LFS/RS] Infer species (strains) tree
Lindsey, please fill in details here, including how you select the single gene families, how sequences were obtained, aligned, and how is the tree inferred. Is bootstrapping done on this?

The sequences to build the species tree were constructed by concatenating homologs of three single-copy core genes selected from the [literature](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-019-2782-9) available online at <https://github.com/stajichlab/FGMP/blob/master/data/593_cleanMarkers.fa>, homologs of _S. cerevisiae_ YKR054C, YHR165C, and YKL182W, for each species in the homolog table.
### 2020-07-06 [HB] Identify homologs in related species
See `../output/blast/README.md` for details.
### 2020-07-09 [HB] Draw new species tree
See `../analysis/README.md` for details
