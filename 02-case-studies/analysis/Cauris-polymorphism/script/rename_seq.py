""" Reformat sequence names
    Bin He
    18 avril 2021
"""

# load libraries
from Bio import SeqIO
import sys

# parse arguments
if len(sys.argv) != 3: # the first element is the program name
    print("python3 rename_seq.py <FASTA> <OUT>")
    sys.exit()

FA = sys.argv[1]  # Fasta file
OUT = sys.argv[2] # output file name

# strain ID table
id_dict = {'KND': 'B6684', 'PIS': 'B8441', 'QEO': 'B11220', 'PSK': 'B11243', 'XP_': 'B11221'}

# create a list to hold the reformatted sequence names and the associated sequences
reformatted = []

# open file for read only, which returns an iterator that goes through each sequence
for record in SeqIO.parse(FA, "fasta"):
    # parse the sequence id
    id_vec = record.description.rsplit(" ")
    prefix = id_vec[0][0:3]
    strain = id_dict[prefix]
    record.id = strain + "_" + id_vec[0]
    record.description = record.id + " " + id_vec[3]
    reformatted.append(record)

with open(OUT, "w") as out:
    SeqIO.write(reformatted, out, "fasta")
