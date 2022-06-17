#!/bin/bash
# title: run FungalRV predictor on protein sequences
# author: Bin He
# date: 2020-06-23
# modified: 2022-06-17, modified to work on a single file

# this assumes that you have downloaded and appropriate svm_classify executable and compiled the C source files and linked them to the current folder. if not, you will encounter errors

set -eo pipefail

if [[ $# -ne 2 ]]
then
	echo "sh run-fungalrv-wrapper.sh <INPUT-FILE> <OUTPUT-DIR>"
	exit
fi

infile=$1
outdir=$2

echo "Processing $infile"
cp $infile tmp.faa
b=fungalRV
perl run_fungalrv_adhesin_predictor.pl tmp.faa $outdir/${b}-results.txt y >|$outdir/${b}.log 2>|$outdir/${b}.err
echo "done"
