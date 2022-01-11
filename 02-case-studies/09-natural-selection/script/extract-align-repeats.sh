# title: extract and align repeat sequences for PAML analysis
# author: Bin He
# date: 2022-01-07
# usage: sh extract-align-repeats.sh

set -eo pipefail

# B8441
aa=../input/source/B8441-Hil-genes.faa
nuc=../input/source/B8441-Hil-genes.fna

## amino acid
for i in ../input/BED/B8441-*-aa.bed
do
	o=${i/-aa.bed/-unaligned.faa}
	bedtools getfasta -fi $aa -bed $i -nameOnly -fo $o
	clustalo -i $o --iter=5 -o ${o/unaligned/aligned} --force
done

## nucleotide
for i in ../input/BED/B8441-*-nuc.bed
do
	o=${i/-nuc.bed/-unaligned.fna}
	bedtools getfasta -fi $nuc -bed $i -nameOnly -fo $o
	# assume that pal2nal.pl is installed
	pal2nal.pl ${i/-nuc.bed/-aligned.faa} $o -codontable 12 -output fasta \
		> ${o/unaligned.fna/aligned.fna}
	# for PAML use
	pal2nal.pl ${i/-nuc.bed/-aligned.faa} $o -codontable 12 -output paml -nogap \
		> ${o/unaligned.fna/aligned.nuc}
done

mv ../input/BED/*.f?a ../input/repeats/
mv ../input/BED/*.nuc ../input/repeats/

# B11221, only one sequence
bedtools getfasta -fi ../input/source/Hil1-2-MDR-full-unaligned.faa \
	-bed ../input/BED/B11221-Hil1-repeats-aa.bed \
	-nameOnly -fo ../input/repeats/B11221-Hil1-repeats-unaligned.faa

bedtools getfasta -fi ../input/source/Hil1-2-MDR-full-unaligned.fna \
	-bed ../input/BED/B11221-Hil1-repeats-nuc.bed \
	-nameOnly -fo ../input/repeats/B11221-Hil1-repeats-unaligned.fna

clustalo -i ../input/repeats/B11221-Hil1-repeats-unaligned.faa \
	-o ../input/repeats/B11221-Hil1-repeats-aligned.faa --force

pal2nal.pl ../input/repeats/B11221-Hil1-repeats-aligned.faa \
	../input/repeats/B11221-Hil1-repeats-unaligned.fna \
	-codontable 12 -output fasta \
	> ../input/repeats/B11221-Hil1-repeats-aligned.fna

pal2nal.pl ../input/repeats/B11221-Hil1-repeats-aligned.faa \
	../input/repeats/B11221-Hil1-repeats-unaligned.fna \
	-codontable 12 -output paml -nogap \
	> ../input/repeats/B11221-Hil1-repeats-aligned.nuc
