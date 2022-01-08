# title: extract repeat sequences using bedtools getfasta
# author: Bin He
# date: 2022-01-07
# usage: sh extract-repeats.sh

set -eo pipefail

# B8441
aa= ../input/B8441-Hil-genes.faa
nuc=../input/B8441-Hil-genes.fna

## amino acid
for i in ../input/B8441-*-aa.bed
do
	bedtools getfasta -fi $aa -bed $i -name -fo ../input/${i/-aa.bed/-unaligned.faa}
done

## nucleotide
for i in ../input/B8441-*-aa.bed
do
	bedtools getfasta -fi $nuc -bed $i -name -fo ../input/${i/-aa.bed/-unaligned.faa}
done

# B11221, only one sequence
bedtools getfasta -fi ../input/Hil1-2-MDR-full-unaligned.faa \
	-bed ../input/B11221-Hil1-repeats-aa.bed \
	-name -fo ../input/B11221-Hil1-repeats-unaligned.faa

bedtools getfasta -fi ../input/Hil1-2-MDR-full-unaligned.fna \
	-bed ../input/B11221-Hil1-repeats-nuc.bed \
	-name -fo ../input/B11221-Hil1-repeats-unaligned.fna
