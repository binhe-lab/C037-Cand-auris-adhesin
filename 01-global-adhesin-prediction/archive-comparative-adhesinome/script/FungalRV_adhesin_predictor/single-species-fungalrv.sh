#!/bin/bash
# title: run FungalRV predictor on protein sequences
# author: Bin He
# date: 2020-06-23, modified to work on a single genome

# this assumes that you have downloaded and appropriate svm_classify executable and compiled the C source files and linked them to the current folder. if not, you will encounter errors

set -eo pipefail

if [[ $# -ne 1 ]]
then
	echo "sh single-species-fungalrv.sh <INPUT-FILE>"
	exit
fi

infile=$1
echo "Processing $infile"
gunzip -c $infile > tmp.faa
outfile=$(basename $infile .faa.gz)
perl run_fungalrv_adhesin_predictor.pl tmp.faa $outfile.txt y >$outfile.log 2>$outfile.err
rm -f ./tmp.faa
echo "done"
