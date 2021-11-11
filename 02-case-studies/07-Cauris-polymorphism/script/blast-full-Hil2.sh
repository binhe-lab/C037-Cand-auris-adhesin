#!/bin/bash
#########################
# author: Bin He
# date: 2021-11-07
# title: blast full Hil2
# use: sh blast-full-Hil2.sh
#########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -u
set -o pipefail

# extract the input sequence
bioawk -c fastx '$name ~ /Hil2/{print ">"$name; print $seq}' ../input/B8441-homologs.fasta > ./query.fa
# parameters
base=../output/copynum-var/Hil2/Hil2-full.tblastn

# tblastn (assumes the blast+ package has been installed locally)
echo "tblastn XP_028889033 full sequence against C. auris genome sequences..."
tblastn -db ../input/blastdb/Cand_auris_strains -query query.fa -db_gencode 12 -evalue 1e-160 -seg "no" -max_hsps 2 -num_threads 4 -outfmt 11 -out $base.asn
# -db_gencode 12: yeast alternative genetic code table when we use the tblastn program
# -evalue 1e-160: cutoff to limit the hits (mainly) to the orthologs for XP_028889033
# -seg "no"     : turn off query masking
# -max_hsps 2   : show only top 2 high scoring pair per subject sequence
# -num_threads 4: use 4 threads
# -outfmt 11    : BLAST achive, can be later converted to other formats
echo "tblastn search complete"

# reformat
echo "reformatting..."
blast_formatter -archive $base.asn -outfmt 0 -out $base.aln
blast_formatter -archive $base.asn -outfmt 3 -out $base.flat
blast_formatter -archive $base.asn -outfmt "7 sseqid qcovs qstart qend slen sstart send qcovshsp pident mismatch evalue" -out $base.txt
blast_formatter -archive $base.asn -outfmt "6 sseqid slen sstart send sseq" -out $base.fasta
echo "done"
