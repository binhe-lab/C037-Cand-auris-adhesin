#!/bin/bash
#########################
# author: Bin He
# date: 2022-04-22
# title: blast NTD of XP_028889033 against K. lactis CBS2015
# use: sh blast-stipitis.sh
#########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -u
set -o pipefail

# parameters
in=../expanded-blast/20220406-expanded-blast-query.fasta
base=./K-lactis-CBS2015-Hil-homologs-blast

# make blast database
cat GCA_007993695.1_ASM799369v1_protein.faa.gz | gunzip -c | makeblastdb -in - -parse_seqids -dbtype prot -title K_lactis_CBS2015 -out ../blastdb/K_lactis_CBS2015

# blastp (assumes the blast+ package has been installed locally)
blastp -db ../blastdb/K_lactis_CBS2015 -query $in -evalue 1e-5 -seg "no" -max_hsps 2 -num_threads 4 -outfmt 11 -out $base.asn
# -evalue 1e-5  : evalue cutoff used in the overall blast. note that evalues are database-specific. so the value here is not actually comparable to the main blast
# -seg "no"     : turn off query masking
# -max_hsps 2   : show only top 2 high scoring pair per subject sequence
# -num_threads 4: use 4 threads
# -outfmt 11    : BLAST achive, can be later converted to other formats

# reformat
blast_formatter -archive $base.asn -outfmt 0 -out $base.aln
blast_formatter -archive $base.asn -outfmt 3 -out $base.flat
blast_formatter -archive $base.asn -outfmt "7 qseqid qcovs sseqid slen pident qstart qend sstart send evalue" -out $base.txt
blast_formatter -archive $base.asn -outfmt "6 sseqid slen sstart send sseq" -out $base.fasta
