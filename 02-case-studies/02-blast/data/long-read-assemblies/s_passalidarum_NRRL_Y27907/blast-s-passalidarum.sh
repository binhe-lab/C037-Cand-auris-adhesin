#!/bin/bash
#########################
# author: Bin He
# date: 2022-05-03
# title: validate blast results in newer genome assembly
# use: sh blast-c-nivariensis.sh
#########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -u
set -o pipefail

# parameters
in=../../expanded-blast/20220406-expanded-blast-query.fasta
db=S_passalidarum-Y27907
base=./S_passalidarum-Y27907-Hil-homologs-blast

# make blast database
cat GCA_013620965.1_ASM1362096v1_genomic.fna.gz | gunzip -c | makeblastdb -in - -parse_seqids -dbtype nucl -title $db -out ../../blastdb/$db

# tblastn (assumes the blast+ package has been installed locally)
tblastn -db ../../blastdb/$db -query $in -evalue 1e-5 -seg "no" -num_threads 4 -outfmt 11 -out $base.asn
# -db_gencode 12: yeast alternative genetic code table when we use the tblastn program
# -evalue 1e-160: based on the result, this is the cutoff that will only include the orthologs for XP_028889033
# -seg "no"     : turn off query masking
# -max_hsps 2   : show only top 2 high scoring pair per subject sequence
# -num_threads 4: use 4 threads
# -outfmt 11    : BLAST achive, can be later converted to other formats

# reformat
blast_formatter -archive $base.asn -outfmt 0 -out $base.aln
blast_formatter -archive $base.asn -outfmt 3 -out $base.flat
blast_formatter -archive $base.asn -outfmt "7 sseqid qcovs qstart qend slen sstart send qcovshsp pident mismatch evalue" -out $base.txt
blast_formatter -archive $base.asn -outfmt "6 sseqid slen sstart send sseq" -out $base.fasta
