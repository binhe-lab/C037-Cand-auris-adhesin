# title: parse PAML distance matrix output
# author: Bin He
# date: 2022-01-08
# usage: sh parse-paml-dist-out.sh IN

set -eo pipefail

in=$1

# PAML's output is in PHYLIP styled format, with the first line giving the number of sequences being compared, then the remaining rows give the lower triangular matrix of distance esimtaes.
# our goal is to separate this file into three parts: the length line, the first column that gives the names of the sequences, and a pure lower triangular matrix

# length
head -1 $in | sed 's/ //g' > tmp.len

# names
sed '1d' $in | cut -d' ' -f1 > tmp.names

# lower tri matrix
sed '1d' $in | tr -s ' ' | cut -d' ' -f2- > tmp.lower
