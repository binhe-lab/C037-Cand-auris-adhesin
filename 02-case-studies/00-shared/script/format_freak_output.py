""" Format the output of EMBOSS:freaq for plotting in R
    Bin He
    9 aout 2020
"""

import sys

# parse arguments
if len(sys.argv) != 2: # the first element is the program name
    print("python3 format_freaq_output.py <input-file>")
    sys.exit(0)

infile = sys.argv[1] # Fasta file
outfile = infile.rsplit(".",1)[0] + "_freak.out"
OUT = open(outfile, "w")
print("id","pos","freq", sep = "\t", file = OUT)

# loop through the file
with open(infile, 'r') as fh:
    for line in fh:
        if line.startswith("FREAK"): # definition line
            seq_name = line.split()[2]
        elif len(line.strip()) == 0: # emptyh lines, do nothing
            continue
        elif line[0].isdigit():      # data line
            pos, freq = line.split() # extract the data
            print(seq_name, pos, freq, sep = "\t", file = OUT)

OUT.close()
