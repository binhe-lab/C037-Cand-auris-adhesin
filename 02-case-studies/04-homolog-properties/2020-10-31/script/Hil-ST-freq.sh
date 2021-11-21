# title: calculate serine threonine frequency for Hil family proteins
# author: Bin He
# date: 2021-11-21

# recommended by BDS textbook
set -eo pipefail

# input files
seq=../data/XP_028889033_homologs.fasta	
bed=../data/XP_028889033_homologs_PF11765.BED
out=../data/XP_028889033_homologs_noPF11765.fasta

# mask the PF11765 domains and produce a fasta without the domain sequences
# ref: https://www.biostars.org/p/263431/
bedtools maskfasta -fi $seq -bed $bed -fo ./tmp
sed 's/N\{50,\}//g' ./tmp > $out
rm -f ./tmp

# calculate the S/T frequency in both files
python calc_STfreq.py $seq > ../output/ST-freq/20211121-Hil-full-STfreq.out
python calc_STfreq.py $out > ../output/ST-freq/20211121-Hil-noPF11765-STfreq.out
