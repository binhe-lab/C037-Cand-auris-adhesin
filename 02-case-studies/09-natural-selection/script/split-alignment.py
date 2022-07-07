""" Split an alignment based on a partition file
    Bin He
    2 juillet 2022
"""

from Bio import AlignIO
import sys

# check for the right number of arguments
if len(sys.argv) != 4:
    print("""
            usage: python3 split-alignment.py <INPUT> <PREFIX> <PARTITION>
                   - <INPUT>    : input fasta file path
                   - <PREFIX>   : output path and prefix for filename
                   - <PARTITION>: filename for the partitions, format:
                                  "name <tab> start <tab> end"
                                  (coordinates are 1-based)
          """)
    sys.exit(0)


# set up input and partitions
infile = sys.argv[1]   # input file name
prefix = sys.argv[2]   # output file prefix
partit = sys.argv[3]   # partition file name
align = AlignIO.read(infile, "fasta")

# read the partition file, then iterate through the partitions to be generated
with open(partit, 'r') as PA:
    for line in PA:
        # split fields by tab
        pname, start, end = line.strip().split('\t')
        outfile = '-'.join([prefix, start, end]) + '.nuc'
        OF = open(outfile, 'w')
        paralign = align[:, (int(start)-1):int(end)]  # slice the alignment
        AlignIO.write(paralign, OF, "phylip-sequential")
        OF.close()
