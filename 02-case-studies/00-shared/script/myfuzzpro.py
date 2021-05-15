""" Identify matches to a regular expression in a protein sequence, record its position
    Bin He
    18 juillet 2020
"""

import re
from Bio import SeqIO
from datetime import datetime
import sys

# check for the right number of arguments
if len(sys.argv) == 2:
    pat = "G?[AVI][VI]{3}T[TA]"
elif len(sys.argv) == 3:
    pat = sys.argv[2]
else:
    print("""
            usage: python3 myfuzzpro.py <FASTA> [PATTERN] (optional), where
            <PATTERN> should be a legitimate regular expression, e.g. G[VI]{1,4}T{0,4}
          """)
    sys.exit(0)

# format the output to be used for the feature map tool on RSAT? (http://rsat-tagc.univ-mrs.fr/rsat/feature-map_form.cgi)
x = input("Output formatted for RSAT feature map tool? (y/N): ")
x = x.upper()

# open file for storing the output
infile = sys.argv[1] # input file name
outfile = "./raw-output/" + infile.rsplit(".",1)[0] + "_feature_map.txt"
out = open(outfile, "w")

# output the header
print("#", datetime.now().strftime("%Y-%m-%d %H:%M"), "HB", sep = " ")
print("# use default pattern", pat, "on", infile, sep = " ")
if x == "Y":
    print("# formatted for feature map")
else:
    print("id", "start", "end", "motif", sep = "\t")

# open file for read only, which returns an iterator that goes through each sequence
for record in SeqIO.parse(infile, "fasta"):
    # convert the sequence from Seq to a plain string
    seq  = str(record.seq)
    if x == "Y":
        # print a header for each sequence to define the sequence limits
        print(record.id, "", "SEQ_START", "DR", 1, 1, sep = "\t", file = out)
        print(record.id, "", "SEQ_END", "DR", len(seq), len(seq), sep = "\t", file = out)
    # re.finditer(pattern, string) returns an iterator (https://www.tutorialspoint.com/How-do-we-use-re-finditer-method-in-Python-regular-expression)
    for m in re.finditer(pat, seq):
        if x == "Y":
            print(record.id, "", m.group(), "D", m.start(), m.end(), sep = "\t", file = out)
        else:
            print(record.id, m.start(), m.end(), m.group(), sep = "\t")

out.close()
