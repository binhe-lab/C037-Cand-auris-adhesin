---
title:  OrthoMCL mapping predicted adhesins to Orthogroups
author: Bin He
date: 2020-03-09
---

# approach
1. Register an account on EupathDB
1. Log on to [EuPathDB Galaxy Server](http://veupathdb.globusgenomics.org/)
1. Follow the workflow for OrthoMCL - uploading the fasta sequence and simply run the workflow to collect the results

# output format

From Tool help for OrthoMCL Map Proteome to Groups

## What it does

Using self-similarity and similarity to OrthoMCL protiens, maps the input proteome to OrthoMCL groups.

Each input protein is mapped to the OrthoMCL group containing its most similar protein in OrthoMCL. These mappings are output to the proteinsMappedToGroups file.

Proteins that have no significant similarity to OrthoMCL proteins are output to the paralogPairs file. This file shows scores between pairs of unmapped proteins. The file is used as input for MCL, to cluster the paralogs

## OUTPUT

`proteinsMappedToGroups.txt` - tab delimited, with these columns: your_protein_id, orthomcl_group_id, most_similar_orthomcl_protein_id, evalue_mantissa, evalue_exponent, percent_identity, percent_match

`paralogPairs.txt` - tab delimited, with these columns: protein_1_id, protein_2_id, score

`.txt` - each row is an MCL group, calculated using the Markov Cluster Algorithm applied to the paralogPairs.txt input file

`MCS.txt` - each row is an MCL group, calculated using the Markov Cluster Algorithm applied to the paralogPairs.txt input file

`blastp.txt` - blastp against OrthoMCL-DB

`self-blastp.txt` - blastp against the submitted sequences

# notes
## _update 2020-03-19_

I realized that in the first try I uploaded the file that contains the FaaPred filtered genes (532 in total). To get the results for all FungalRV predicted adhesins, I re-concatenated the adhesin genes (in `data/predicted_adhesins`) and repeated the procedure above

## _update 2020-05-16_

Resubmitted the sequences to VEupathDB (a new site integrating EupathDB, FungiDB and VectorBase) using OrthoMCL-DB v6r1 (previously I used v5)

## _update 2020-05-18_

The results from mapping to v5 and v6r1 are not the same. Each has its own unique entries. For example, "XP_447684.1" is mapped to OG6_128677 in v6r1, but failed to be mapped for v5. After checking the blasp results, I found that the gene actually yielded MANY hits in the v5 result, but all of the hits have cgla|XP_xxxx format, instead of the CAGL0Kxxx format, which suggests that the v5 and v6r1 OrthoMCL blast databases are quite different. As to why, despite having many hits in the v5 blastp result, it failed to be mapped with v5, I can't quite figure out.

## _update 2020-06-05_

This time I added _S. cerevisiae_ results to the list. All files with this date are the new results.

## _update 2020-06-06_

_C. auris_ B8441 is incorporated into OrthoMCL v6r1. I used the new [FungiDB beta](https://beta.fungidb.org/fungidb.beta/app/) to download the results for all four genomes (using the "Strategy"->"add"->"union" feature), and selected Gene_ID, Organism, Orthogroup_ID, Protein length, Pfam ID, Pfam description fields. Intend to cross-check this result with my custom mapping using their Galaxy site later.

I edited the file to make the column names suitable for R and removed the trailing tab, all done in vim.
