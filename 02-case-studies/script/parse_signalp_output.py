""" Parse SignalP output (actually produced by GPI-SOM)
    Bin He
    29 aout 2020
"""

import sys

# parse arguments
if len(sys.argv) != 2: # the first element is the program name
    print("python3 parse_signalp_output.py <input-file>")
    sys.exit(0)

infile = sys.argv[1] # Fasta file
outfile = infile.rsplit(".",1)[0] + "-parsed.out"
OUT = open(outfile, "w")
print("id","cleaveSite",sep = "\t", file = OUT)

# loop through the file
with open(infile, 'r') as fh:
    for line in fh:
        if line.startswith(">"): # definition line
            seq_name = line.split()[0][1:] # remove the first ">"
            line = next(fh) # get the next line
            cleavesite = line.split()[4].split(":")[1] # get the cleavage site
            print(seq_name, cleavesite, sep = "\t", file = OUT)
        elif len(line.strip()) == 0: # emptyh lines, do nothing
            continue

OUT.close()
