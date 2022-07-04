# title: align PF11765 seqs for PAML analysis
# author: Bin He
# date: 2022-07-01
# usage: bash align-B8441-OG.sh

set -eo pipefail

# B8441
aa=../input/homologs/B8441-OG-Hil-PF11765-unaligned.faa
aaa=${aa/unaligned/aligned}
nuc=../input/homologs/B8441-OG-Hil-PF11765-unaligned.fna
nuca=${nuc/unaligned/aligned}

## align amino acid
clustalo -i $aa --iter=15 -o $aaa --force

# assume that pal2nal.pl is installed
pal2nal.pl $aaa $nuc -codontable 12 -output fasta \
	> $nuca
# for PAML use
# pal2nal.pl $aaa $nuc -codontable 12 -output paml \
# 	> ${nuca/fna/nuc}
