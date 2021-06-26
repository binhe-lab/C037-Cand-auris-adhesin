#!/bin/bash
#########################
# author: Bin He
# date: 2021-05-10
# title: xstream tandem repeat identification
# use: sh xstream.sh input.fasta output-name output-dir
#########################

# these are useful flags to set to make the code more robust to failure
# copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -o pipefail

# check parameters
if [ "$#" -ne 3 ]; then
	echo "Usage: sh xstream.sh input.fasta output-name output-dir"
	exit
fi

# set the variables
in=$1
name=$2
out=${3%/}

# assuming xstream.jar is located at ~/sw/XSTREAM
java -Xmx1000m -Xms1000m -jar xstream.jar $in -i.7 -I.7 -g3 -e2 -L15 -z -Asub.txt -B -O -a$name
# -i.7: minimum word match 70%
# -I.7: minimum consensus match 70% (for high degeneracy) 
# -g3 : maximum gaps 3
# -e2 : minimum copy number 2
# -L15: minimum TR domain length (e.g. TR is valid with period = 3, with 5 copies)
# -z  : create excel spreadsheet of TR output
# -a  : insert custom name into output files
# -O  : change multiple alignment color format to highlight gaps/mismatches
# -B  : generate TR block diagram output (PNG)
# -A  : use substitution alphabet
mv XSTREAM* ${out}/
