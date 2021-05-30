# title: calculate S/T frequency
# author: Bin He
# date: 2021-05-30

set -euo pipefail

# set parameters
in=../input/cauris-four-strains-for-seq-features.fasta
out=../output/seq-feature/

# assume that EMBOSS/freak is installed and in the path
freak $in -letters "ST" -window 100 -step 10 -outfile ST_freq_100_10.freak -odirectory $out
freak $in -letters "T" -window 100 -step 10 -outfile T_freq_100_10.freak -odirectory $out
freak $in -letters "S" -window 100 -step 10 -outfile S_freq_100_10.freak -odirectory $out

# format output files
for i in ${out}*.freak; do python format_freak_output.py $i; done
