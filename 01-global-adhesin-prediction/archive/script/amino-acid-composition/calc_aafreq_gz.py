"""Calculate cysteine and dibasic peptide frequencies in protein from fasta file
   Bin He
   2020-02-27
   modified to use gzip files as input
"""

import gzip
from Bio import SeqIO
import sys

IN = sys.argv[1] # input file name

# print header
print("# <ID>","<length>","<#Cys>","<#Dibasic>", sep = "\t")

# iterate through the fasta file
with gzip.open(IN, "rt") as handle:
	for record in SeqIO.parse(handle, "fasta"):
		freq_Cys = record.seq.upper().count("C")
		freq_Dibasic = sum([record.seq.upper().count(m) for m in ["RR","RK","KR","KK"]])
		print(record.id, len(record.seq), freq_Cys, freq_Dibasic, sep = "\t")
