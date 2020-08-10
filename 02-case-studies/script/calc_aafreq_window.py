"""Calculate the frequency of given amino acid(s) in a sliding window for the given sequences
   Modified from the version used to calculate cysteine frequency and report only the maximum
   Bin He
   2020-08-09
"""

from Bio import SeqIO
import sys

# check for the right number of arguments
if len(sys.argv) != 5:
    print("""
            usage: python3 myfreq.py <FASTA> <CHARACTERS> <WINDOW> <STEP>
                   - <FASTA>: input file name
                   - <CHARACTERS> single or multiple letters to count, e.g. C or ST
                                  if there are more than one character in <CHARACTERS>, they are interpreted as "OR"
                                  i.e. their frequency in a given sliding window will be summed and reported.
                   - <WINDOW> is the size of the sliding window
                   - <STEP> step size for the sliding window
          """)
    sys.exit(0)


infile = sys.argv[1] # input file name
outfile = infile.rsplit(".",1)[0] + "_freq.txt"
out = open(outfile, "w")
char = sys.argv[2] # characters to search
wlen = sys.argv[3] # length of sliding window
step = sys.argv[4] # step size of the sliding window

def slide_window(name, seq, pattern, wsize, wstep):
    """ use a sliding window to calculate the frequency of a given amino acid or amino acid(s)
        and report the frequency for each window in a table format
    """
    cnt = 0
    # for sequences whose size is smaller than the window size, simply return the total count
    if len(seq) < size:
        cnt = [seq.count(x) for x in pattern]
        print()
    # for sequences longer than the window size, run a sliding window
    else:
        for pos in range(0, len(seq)-size+1, size):
            cnt = [seq[pos:pos+size].count(x) for x in pattern]
            # stopped here
            freq = sum(cnt)/size
            if freq > maxFreq:
                maxFreq = freq
        return maxFreq

def calc_freq(infile):
    # print header
    print("# <ID>","<length>","<#Cys>","<#Dibasic>", sep = "\t")
    
    # iterate through the fasta file
    for record in SeqIO.parse(infile, "fasta"):
        freq_Cys = slide_window(seq = record.seq.upper(), AA = "C", size = 300, step = 10)
        freq_Dibasic = sum([record.seq.upper().count(m) for m in ["RR","RK","KR","KK"]])
        print(record.id, len(record.seq), freq_Cys, freq_Dibasic, sep = "\t")

# call main function
calc_freq(IN)
