#!/bin/sh
# title: extract sequences from a large fasta file based on sequence name
# author: Lindsey, Yann, Bin
# date: 2020-01-31
# use: sh extract_fasta.sh <fasta file> <ID file>

fasta=$1
id_file=$2


#1. isolate IDs from FungalRV predicted adhesins list
awk '{print $1}' $id_file > ${id_file/.*}_ID.txt #{xxx/.*} removes the suffix

#2. linearize the fasta
awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' $fasta > ${fasta/.*}_linear.txt

#3. extract the predicted adhesins based on ID

while read IDS
do 
	grep "\b$IDS\b" ${fasta/.*}_linear.txt
done < ${id_file/.*}_ID.txt > ${fasta/.*}_linear_filtered.txt 

#4. wrap sequences
tr '\t' '\n' ${fasta/.*}_linear_filtered.txt > ${fasta/.*}_filtered.fas

echo "Done with $1"
