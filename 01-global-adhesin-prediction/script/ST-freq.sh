# title: calculate Ser/Thr frequency in 50 amino acid non-overlapping windows for C. auris proteome
# author: Bin He
# date: 2021-07-15

# safe bash scripts
set -eu -o pipefail

# calculate the Ser/Thr frequencies in each protein in 100 bp sliding windows with a step size of 10
gunzip -c ../data/proteome-fasta/Caurisfasta.faa.gz | freak -filter -letters "ST" -window 100 -step 10 > ../output/ST-freq/ST_freq_100_10.freak
python format_freak_output.py ../output/ST-freq/ST_freq_100_10.freak

# calculate the Ser frequencies in each protein in 100 bp sliding windows with a step size of 10
gunzip -c ../data/proteome-fasta/Caurisfasta.faa.gz | freak -filter -letters "S" -window 100 -step 10 > ../output/ST-freq/S_freq_100_10.freak
python format_freak_output.py ../output/ST-freq/S_freq_100_10.freak

# calculate the Thr frequencies in each protein in 100 bp sliding windows with a step size of 10
gunzip -c ../data/proteome-fasta/Caurisfasta.faa.gz | freak -filter -letters "T" -window 100 -step 10 > ../output/ST-freq/T_freq_100_10.freak
python format_freak_output.py ../output/ST-freq/T_freq_100_10.freak

# gzip everything for storage
# gzip ../output/ST-freq/*freak*
