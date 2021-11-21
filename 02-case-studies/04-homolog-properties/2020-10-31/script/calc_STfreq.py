"""
title: Calculate Ser/Thr frequencies in protein sequences
author: Bin He
date: 2021-11-21
"""

from Bio import SeqIO
import sys

IN = sys.argv[1] # input file name

# print header
print("ID","length","Ser","Thr", sep = "\t")

# iterate through the fasta file
for record in SeqIO.parse(IN, "fasta"):
    freq_Ser = record.seq.upper().count("S")
    freq_Thr = record.seq.upper().count("T")
    print(record.id, len(record.seq), freq_Ser, freq_Thr, sep = "\t")
