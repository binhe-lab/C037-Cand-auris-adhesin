The raw hmm model file for Hyphal_reg_CWP domain was downloaded from the pfam database as of 2022-05-04. The following code using hmmer v3.3.2 was used to prepare the profile database for use with `hmmscan`
`hmmpress Hyphal_reg_CWP.hmm`

Afterwards, the scan was done as follows (cwd = `script`):
`hmmscan -o 20220504-hmmscan.log --domtblout ../output/20220504-expanded-blast-refseq-homologs.faa --noali --domE 1e-3 ../data/HMM-profile/Hyphal_reg_CWP.hmm ../output/20220503-expanded-blast-refseq-homologs.faa`
