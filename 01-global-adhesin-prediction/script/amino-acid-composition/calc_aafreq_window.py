"""Calculate cysteine and dibasic peptide frequencies in protein from fasta file
   Modified from the first version to use a sliding window to calculate the frequency
   Bin He
   2020-03-06
"""

from Bio import SeqIO
import sys

IN = sys.argv[1] # input file name

def slide_window(seq, AA = "C", size = 300, step = 10):
    """ use a sliding window to calculate the frequency of cysteine (or other amino acid) 
        in amino acid sequences, and return the highest number
    """
    maxFreq = 0
    # for proteins whose size is smaller than the window size, simply return the total count of AA
    if len(seq) < size:
        return seq.count(AA)

    for pos in range(0, len(seq)-size+1, size):
        freq = seq[pos:pos+size].count(AA)
        if freq > maxFreq:
            maxFreq = freq
    return maxFreq

def calc_freq(infile):
    # print header
    print("# <ID>","<length>","<#Cys>","<#Dibasic>", sep = "\t")
    
    # iterate through the fasta file
    for record in SeqIO.parse(infile, "fasta"):
        freq_Cys = slide_window(seq = record.seq.upper(), AA = "C", size = 300, step = 10)
        freq_Dibasic = sum([record.seq.upper().count(m) for m in ["RR","RK","KR","KK"]])
        print(record.id, len(record.seq), freq_Cys, freq_Dibasic, sep = "\t")

# call main function
calc_freq(IN)
