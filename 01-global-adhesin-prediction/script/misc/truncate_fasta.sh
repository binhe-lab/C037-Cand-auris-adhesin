#! /bin/bash
# this script is a simple wrapper to output just the first N characters of a fasta multiple sequences file
# Bin He
# 2020-06-27
#

set -eo pipefail

if [[ "$#" -ne 2 ]]; then
	echo "Usage: sh truncate_fasta.py <INPUT> <LENGTH>"
	exit 1
fi

in=$1
length=$2
# this program assumes that bioawk (https://github.com/lh3/bioawk) is installed

bioawk -c fastx -v l="$length" '{print ">"$name;print substr($seq,1,l)}' $in
