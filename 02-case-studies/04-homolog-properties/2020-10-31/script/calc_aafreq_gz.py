"""
Calculate cysteine and dibasic peptide frequencies in protein from fasta file
Bin He
2020-02-27
modified to use gzip files as input
2021-06-28
modified to calculate serine threonine content
"""

import gzip
from Bio import SeqIO
import sys

IN = sys.argv[1] # input file name

# print header
print("ID","length","Ser","Thr", sep = "\t")

# iterate through the fasta file
with gzip.open(IN, "rt") as handle:
	for record in SeqIO.parse(handle, "fasta"):
		freq_Ser = record.seq.upper().count("S")
		freq_Thr = record.seq.upper().count("T")
		print(record.id, len(record.seq), freq_Ser, freq_Thr, sep = "\t")
