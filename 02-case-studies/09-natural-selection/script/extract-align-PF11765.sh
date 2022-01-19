# title: extract and align PF11765 seqs for PAML analysis
# author: Bin He
# date: 2022-01-15
# usage: sh extract-align-PF11765.sh

set -eo pipefail

# B8441
aa=../input/source/cauris-four-strains-for-seq-features.fasta
nuc=../input/source/MDR-homologs-cds-named-after-protein.fna

## amino acid
i=../input/BED/MDR-homologs-PF11765-aa.bed
o=${i/-aa.bed/-unaligned.faa}
bedtools getfasta -fi $aa -bed $i -nameOnly -fo $o
clustalo -i $o --iter=15 -o ${o/unaligned/aligned} --force

## nucleotide
i=../input/BED/MDR-homologs-PF11765-nuc.bed
o=${i/-nuc.bed/-unaligned.fna}
bedtools getfasta -fi $nuc -bed $i -nameOnly -fo $o
# assume that pal2nal.pl is installed
pal2nal.pl ${i/-nuc.bed/-aligned.faa} $o -codontable 12 -output fasta \
	> ${o/unaligned.fna/aligned.fna}
# for PAML use
pal2nal.pl ${i/-nuc.bed/-aligned.faa} $o -codontable 12 -output paml \
	> ${o/unaligned.fna/aligned.nuc}

mv ../input/BED/*.f?a ../input/homologs/
mv ../input/BED/*.nuc ../input/homologs/
