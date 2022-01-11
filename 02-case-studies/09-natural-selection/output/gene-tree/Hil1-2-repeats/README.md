```
# nucleotide tree
raxml-ng --msa input/repeats/B8441-Hil1-2-repeats-combined.fna --model GTR+G --seed 123 --threads 3 --prefix output/gene-tree/Hil1-2-repeats/20220111nuc
# bootstrap run #1, 1000 replicates
raxml-ng --msa input/repeats/B8441-Hil1-2-repeats-combined.fna --model GTR+G --seed 123 --threads 7 --bootstrap --prefix output/gene-tree/Hil1-2-repeats/20220111nuc1
# not converged, bootstrap run #2, 1000 replicates
raxml-ng --msa input/repeats/B8441-Hil1-2-repeats-combined.fna --model GTR+G --seed 333 --threads 7 --bootstrap --prefix output/gene-tree/Hil1-2-repeats/20220111nuc1
# check convergence
raxml-ng --bsconverge --bs-trees 20220111nuc.raxml.all.bootstraps

# amino acid tree
raxml-ng --msa input/repeats/B8441-Hil1-2-repeats-combined.faa --model LG+G --seed 123 --threads 3 --prefix output/gene-tree/Hil1-2-repeats/20220111aa
```
