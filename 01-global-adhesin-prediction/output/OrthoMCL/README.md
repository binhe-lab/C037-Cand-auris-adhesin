---
title:  OrthoMCL mapping predicted adhesins to Orthogroups
author: Bin He
date: 2020-03-09
---

# approach
1. Register an account on EupathDB
1. Log on to [EuPathDB Galaxy Server](http://veupathdb.globusgenomics.org/)
1. Follow the workflow for OrthoMCL - uploading the fasta sequence and simply run the workflow to collect the results

_update 2020-03-19_

I realized that in the first try I uploaded the file that contains the FaaPred filtered genes (532 in total). To get the results for all FungalRV predicted adhesins, I re-concatenated the adhesin genes (in `data/predicted_adhesins`) and repeated the procedure above

_update 2020-03-19_

Resubmitted the sequences to VEupathDB (a new site integrating EupathDB, FungiDB and VectorBase) using OrthoMCL-DB v6r1 (previously I used v5)
# output format

Tool help for OrthoMCL Map Proteome to Groups
## What it does

Using self-similarity and similarity to OrthoMCL protiens, maps the input proteome to OrthoMCL groups.

Each input protein is mapped to the OrthoMCL group containing its most similar protein in OrthoMCL. These mappings are output to the proteinsMappedToGroups file.

Proteins that have no significant similarity to OrthoMCL proteins are output to the paralogPairs file. This file shows scores between pairs of unmapped proteins. The file is used as input for MCL, to cluster the paralogs

## OUTPUT

**proteinsMappedToGroups.txt** - tab delimited, with these columns: your_protein_id, orthomcl_group_id, most_similar_orthomcl_protein_id, evalue_mantissa, evalue_exponent, percent_identity, percent_match

**paralogPairs.txt** - tab delimited, with these columns: protein_1_id, protein_2_id, score

**MCS.txt** - each row is an MCL group, calculated using the Markov Cluster Algorithm applied to the paralogPairs.txt input file
