"""This script is based on https://biopython.org/wiki/Split_large_file
   used to split a large input fasta to batches of N smaller files
   Bin He, 2020-05-30
"""

from Bio import SeqIO
import sys

infile = sys.argv[1]

all_rec = list(SeqIO.parse(open(infile), "fasta"))

n = 1
size = 25
for i in range(0, len(all_rec), size):
    filename = "split_%i.fasta" % n
    with open(filename, "w") as handle:
        count = SeqIO.write(all_rec[i:i+size], handle, "fasta")
    print("Wrote %i records to %s" % (count, filename))
    n += 1