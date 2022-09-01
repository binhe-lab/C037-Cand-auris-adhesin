# title: calculate S/T frequency
# author: Bin He
# date: 2022-08-24

set -euo pipefail

# set parameters
w=50
s=10
in=../input/B8441-homologs.fasta
out=../output/seq-feature/

# assume that EMBOSS/freak is installed and in the path
freak $in -letters "ST" -window $w -step $s -outfile B8441_ST_freq_${w}_${s}.freak -odirectory $out
freak $in -letters "T" -window $w -step $s -outfile B8441_T_freq_${w}_${s}.freak -odirectory $out
freak $in -letters "S" -window $w -step $s -outfile B8441_S_freq_${w}_${s}.freak -odirectory $out

# format output files
for i in ${out}*.freak; do python format_freak_output.py $i; done
