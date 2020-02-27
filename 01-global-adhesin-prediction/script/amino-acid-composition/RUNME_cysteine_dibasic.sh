#!/bin/bash
# title: calculate the cystein and dibasic frequencies in predicted adhesins
# author: Bin He
# date: 2020-02-26
# usage: ./RUNME_cysteine_dibasic.sh

# requires bioawk, EMBOSS/6.6.0

echo "# dibasic motif frequency (RR|KK|KR|RK)\n# <seq ID> <freq> <perc>" > dibasic_freq_all_predicted_adhesin_20200226.txt
bioawk -c fastx -f dibasic.awk ../../data/predicted-adhesins/all_predicted_adhesins_20200226.fasta >> dibasic_freq_all_predicted_adhesin_20200226.txt
echo "# cysteine frequency\n# <seq ID> <freq> <perc>" > cysteine_freq_all_predicted_adhesin_20200226.txt
bioawk -c fastx -f cysteine.awk ../../data/predicted-adhesins/all_predicted_adhesins_20200226.fasta >> cysteine_freq_all_predicted_adhesin_20200226.txt
