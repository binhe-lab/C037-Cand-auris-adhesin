""" Extract sequence accession #, species and length
    Bin He
    19 juillet 2020
"""

from Bio import SeqIO
from datetime import datetime
import sys

# open file for storing the output
infile = "./XP_028889033_homologs.fasta" # input file name
outfile = "./raw-output/XP_028889033_homologs.tsv" # output file name
out = open(outfile, "w")

# output the header
print("#", datetime.now().strftime("%Y-%m-%d %H:%M"), "HB", sep = " ", file = out)
print("name", "id", "species", "length", sep = "\t", file = out)

# open file for read only, which returns an iterator that goes through each sequence
for record in SeqIO.parse(infile, "fasta"):
    # parse the sequence id
    ID, species = record.id.rsplit("_",1)
    print(record.id, ID, species, len(record.seq), sep = "\t", file = out)

out.close()
