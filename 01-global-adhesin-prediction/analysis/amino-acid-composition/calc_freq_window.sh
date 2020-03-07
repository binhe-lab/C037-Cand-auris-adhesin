#!/bin/bash
# call the python program to process all the gz files
# Bin He
# 2020-03-06
# the system python must be python3

for f in *-protein.faa.gz
do
	python calc_freq_window_gz.py $f > ${f%%.*}-genome-freq-window.txt
	echo "done $f"
done
