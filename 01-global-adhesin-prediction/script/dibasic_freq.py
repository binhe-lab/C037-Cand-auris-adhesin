"""
Calculate dibasic peptide frequencies in GPI-anchored proteins
Bin He
2020-07-27
"""

import gzip
from Bio import SeqIO
import re
import sys

if len(sys.argv) != 3:
    print(
    '''
    This program determines if a dibasic peptide motif is present in the 11 residues
    prior to the ω-site and prints the results to the standard output
    
    Usage: python dibasic_freq.py <FASTA> <PredGPI-result>
    ''')
    sys.exit(1)

FA = sys.argv[1]  # input file name
GPI = sys.argv[2] # PredGPI result

# print header
print("name","seq","dibasic", sep = "\t")

omega_res = {}   # initiate an empty dictionary to store the omega site residue
omega_pos = {}   # initiate an empty dictionary to store the omega site location
# parse the PredGPI result file and store the ω-site position in a dictionary.
with open(GPI, 'r') as fh:
    for line in fh:
        # split the line using " | " and assign the components to variables
        id, fp, omega = line.split(" | ") 
        id = id[1:] # remove the preceding ">"
        # use a regular expression to extract the cleavage residue and cleavage site
        # https://docs.python.org/3/howto/regex.html
        m = re.match(r'OMEGA:(\w)-(\d+)', omega)
        omega_res[id] = m.group(1)
        omega_pos[id] = int(m.group(2))
        
pattern = re.compile('[KR]{2}') # search pattern
# iterate through the fasta file
with gzip.open(FA, "rt") as handle:
    for record in SeqIO.parse(handle, "fasta"):
        name = record.id
        if name in omega_res:   # if the id is in 
            seq = record.seq
            pos = int(omega_pos[name])
            # extract the -12 to -1 residues prior to the cleavage site
            omega_minus = str(seq[(pos-13):(pos-1)])
            m = pattern.search(omega_minus[::-1]) # search backwards
            if m:
                '''
                if there is a match, the negative of the end position is the start 
                of the motif counting backwards from the cleavage residue
                '''
                dibasic = m.end()
            else: # if no match
                dibasic = "NA"
            # print the name (ID), the omega_minus and the ω-site residue, and the dibasic motif position
            print(name, "-".join([omega_minus, str(seq[pos-1])]), dibasic, sep = "\t")
        else:
            print(name, "NA", "NA", sep = "\t")
