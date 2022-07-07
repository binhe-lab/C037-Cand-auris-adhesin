#!/bin/bash
# title: reconstruct gene tree
# author: Bin He
# date: 2022-07-01
# use: copy and paste the commands here into the terminal and run one-by-one

set -euo pipefail

# get all partitioned files
in=$(ls ../input/homologs/B8441-OG-Hil-PF11765-*.nuc)

for i in $in
do
	echo "Inferring tree for $i"
	base=$(basename $i '.nuc')
	o=../input/gene-tree/B8441-Hil-PF11765-split/$base
	raxml-ng --all --msa $i --model GTR+G --seed 123 --threads 4 --bs-trees autoMRE --outgroup OG --prefix $o
done

# 2022-07-01 B8441-Hil-PF11765-1-699
#raxml-ng --all --msa ../input/homologs/B8441-Hil1-8-PF11765-1-699.fna --model GTR+G --seed 123 --threads 4 --bs-trees autoMRE --prefix ../input/gene-tree/B8441-Hil-PF11765-split/B8441-Hil-PF11765-1-699

# 2022-07-01 B8441-Hil-PF11765-700-975
#raxml-ng --all --msa ../input/homologs/B8441-Hil1-8-PF11765-700-975.fna --model GTR+G --seed 123 --threads 4 --bs-trees autoMRE --prefix ../input/gene-tree/B8441-Hil-PF11765-split/B8441-Hil-PF11765-700-975

