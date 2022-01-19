## 20211227a
note: the original alignment file has since been removed. this gene tree analysis is no longer in use and will be updated with a full MDR clade analysis
`raxml-ng --msa input/homologs/Hil1-2-MDR-NTD-aligned.faa --model LG+G --seed 123 --threads 3 --prefix output/gene-tree/Hil1-2-MDR-NTD/20211227a`
## 20220114a
retained only B8441 for _C. auris_, to be used with the new paml analysis
`raxml-ng --msa input/homologs/Hil1-2-MDR-PF11765-clustalo.faa --model LG+G --seed 123 --threads 3 --prefix output/gene-tree/Hil1-2-MDR-NTD/20220114a`
