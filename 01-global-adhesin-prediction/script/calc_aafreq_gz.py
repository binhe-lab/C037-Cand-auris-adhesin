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

if len(sys.argv) != 2:
    print(
    '''
    This program computes the frequency of Serines and Threonines in each sequence in the input
    and prints the results to the standard output
    
    Usage: python calc_aafreq_gz.py <INPUT_FILE>
    ''')
    sys.exit(1)

IN = sys.argv[1] # input file name

# print header
print("ID","length","Ser","Thr", sep = "\t")

# iterate through the fasta file
with gzip.open(IN, "rt") as handle:
	for record in SeqIO.parse(handle, "fasta"):
		freq_Ser = record.seq.upper().count("S")
		freq_Thr = record.seq.upper().count("T")
		print(record.id, len(record.seq), freq_Ser, freq_Thr, sep = "\t")
