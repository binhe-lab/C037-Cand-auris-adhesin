""" Format the output of CD-hit for analysis in R
    Bin He
    18 juillet 2021
"""

import sys

# parse arguments
if len(sys.argv) != 3: # the first element is the program name
    print("python3 format_cd-hit_output.py <infile> <outfile>")
    sys.exit(0)

infile = sys.argv[1] # input file
outfile = sys.argv[2] # output file
OUT = open(outfile, "w")
print("cluster","id","identity", sep = "\t", file = OUT)

cluster = -1 # initialize cluster number

# loop through the file
with open(infile, 'r') as fh:
    for line in fh:
        if line.startswith(">"): # cluster number
            cluster = line.split()[1]
        elif len(line.strip()) == 0: # emptyh lines, do nothing
            continue
        elif line[0].isdigit():      # data line
            # first remove the "at " so all lines will be split into four elements
            unpacked = line.replace("at ", "").split() 
            pid = unpacked[2][1:-3]   # extract the ID by removing the prefix and postfix
            identity = unpacked[3]    # percent identity
            print(cluster, pid, identity, sep = "\t", file = OUT)

OUT.close()
