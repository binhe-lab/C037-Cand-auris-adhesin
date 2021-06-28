#! /bin/bash
# this script is a simple wrapper to output just the first N characters of a fasta multiple sequences file
# Bin He
# 2020-06-27
# modified 2020-06-29 by HB
# to add the alignment function
# assuming that clustalo is in the PATH
# this program assumes that bioawk (https://github.com/lh3/bioawk) is installed

set -eo pipefail

if [[ "$#" -ne 2 ]]; then
	echo "Usage: sh truncate_fasta.py <INPUT> <LENGTH>"
	exit 1
fi

in=$1
length=$2
base=${1%.*}
trunc=${base}_N${length}.faa
align=${base}_N${length}_aln.faa

# truncate using bioawk
bioawk -c fastx -v l="$length" '{print ">"$name;print substr($seq,1,l)}' $in > $trunc

# align with clustalo
clustalo -i $trunc -o $align -iter=100
