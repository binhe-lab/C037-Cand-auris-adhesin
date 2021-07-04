"""Extract the subset of fasta sequences given the sequence names
   Bin He
   2020-06-06
"""

# import libraries
from Bio import SeqIO
import sys
import re

# parse arguments
if len(sys.argv) != 3: # the first element is the program name
    print("python3 extract_fasta.py <FASTA> <SEQ NAMES>")
    sys.exit()

FA = sys.argv[1] # Fasta file
IN = sys.argv[2] # Seq names
OUT = re.sub("\.txt",".faa", IN)

# read in fasta and turn it into a dictionary https://biopython.org/wiki/SeqIO
with open(FA, "r") as FH:
    fasta_records = SeqIO.to_dict(SeqIO.parse(FH, "fasta"))

# create a container for filtered results
filtered = []

# iterate through the FungalRV result file
with open(IN, "r") as f:
    for name in f:
        filtered.append(fasta_records[name.rstrip()])

SeqIO.write(filtered, OUT, "fasta")
