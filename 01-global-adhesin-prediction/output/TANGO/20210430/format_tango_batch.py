"""Format a fasta sequence file for TANGO analysis in batch mode
   Parameters based on Rachel's notes in 01-global-analysis/output/TANGO/README.md
   Bin He
   2020-08-10
   modified 2021-04-30
   Rachel's sequence names didn't have the ending species names
   also, note that to run this on ARGON, need to load py-biopython module
"""

# import libraries
from Bio import SeqIO
import sys
import re

# parse arguments
if len(sys.argv) != 2: # the first element is the program name
    print("python3 format_tango_input.py <FASTA>")
    sys.exit()

infile = sys.argv[1] # Fasta file
outfile = infile.rsplit(".",1)[0] + "_tango.sh"
out = open(outfile, "w")

# tango parameters (this is based on Rachel's note)
# 'nt="N"ct="N" ph="7.5" te="298" io="0.1" tf="0" stab="-10" conc="1"'
# but the tango v2.3.1 complains about the input. the tf parameter seems to be no longer needed
# therefore I removed it
param = 'ct="N" nt="N" ph="7.5" te="298" io="0.1" tf="0" stab="-10" conc="1"'

# open file for read only, which returns an iterator that goes through each sequence
for record in SeqIO.parse(infile, "fasta"):
    id = record.id
    # convert the sequence from Seq to a plain string
    seq  = str(record.seq)
    # print a header for each sequence to define the sequence limits
    print("./tango2_3_1", id, param, 'seq="'+seq+'"', sep = " ", file = out)

out.close()
