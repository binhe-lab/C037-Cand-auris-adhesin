# title: calculate serine threonine frequency for Hil family proteins
# author: Bin He
# date: 2022-06-23

# recommended by BDS textbook
set -eo pipefail

# input files
seq= ../data/expanded-blast-homologs-edited.faa
bed=../data/20220623-expanded-blast-combined-homologs-PF11765-longname.BED
out=../data/20220623-expanded-blast-combined-homologs-noPF11765.fasta

# mask the PF11765 domains and produce a fasta without the domain sequences
# ref: https://www.biostars.org/p/263431/
bedtools maskfasta -fi $seq -bed $bed -fo ./tmp
sed 's/N\{50,\}//g' ./tmp > $out
rm -f ./tmp

# calculate the S/T frequency in both files
python calc_STfreq.py $seq > ../output/ST-freq/20220623-Hil-full-STfreq.out
python calc_STfreq.py $out > ../output/ST-freq/20220623-Hil-noPF11765-STfreq.out
