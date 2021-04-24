""" Extract sequence accession #, species, strain and length
    Bin He
    24 avril 2021
"""

from Bio import SeqIO
from datetime import datetime
import sys

# open file for storing the output
infile = "../input/cauris-five-strains-for-gene-tree.fasta" # input file name
outfile = "../output/seq-feature/cauris-homologs-list.tsv" # output file name
out = open(outfile, "w")

# output the header
print("#", datetime.now().strftime("%Y-%m-%d %H:%M"), "HB", sep = " ", file = out)
print("name", "id", "species", "strain", "length", sep = "\t", file = out)

# strain information for the non-Cauris species, in a dictionary
strains = {"Chaemuloni": "B11899", "Cpseudohaemulonis": "B12108", "Dhansenii": "CBS767"}

# open file for read only, which returns an iterator that goes through each sequence
for record in SeqIO.parse(infile, "fasta"):
    # parse the sequence id
    tmp, species = record.id.rsplit("_",1)
    if species == "Cauris":
        ID, strain = tmp.rsplit("_",1)
    else:
        ID = tmp
        strain = strains[species]
    print(record.id, ID, species, strain, len(record.seq), sep = "\t", file = out)

out.close()
