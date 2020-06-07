"""Extract the subset of fasta sequences based on FungalRV score
   Bin He
   2020-05-30
"""

# import libraries
import gzip
from Bio import SeqIO
import sys
import re

# parse arguments
if len(sys.argv) != 3:
    print("python3 extract_fasta.py <FungalRV result> <FASTA gzipped>")
    exit()

IN = sys.argv[1] # FungalRV result
FA = sys.argv[2] # Fasta file
OUT = re.sub("\.faa\.gz","_filtered.faa", FA)

# unzip the input file
FH = gzip.open(FA, "rt")

# read in fasta and turn it into a dictionary https://biopython.org/wiki/SeqIO
fasta_records = SeqIO.to_dict(SeqIO.parse(FH, "fasta"))

# create a container for filtered results
filtered = []

# iterate through the FungalRV result file
with open(IN, "r") as f:
    # skip the first three lines
    f.readline()
    f.readline()
    f.readline()
    # iterate through the rest of the file
    for line in f:
        long_id, score = line.strip(">\n").split("\t") # remove the ">" at the beginning and the trailing \n
        if float(score) > 0:
            acc = long_id.split(" ")[0]
            filtered.append(fasta_records[acc])

SeqIO.write(filtered, OUT, "fasta")
