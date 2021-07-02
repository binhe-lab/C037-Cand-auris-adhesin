# title: calculate serine threonine frequency for representative proteomes
# author: Bin He
# date: 2021-06-28

files=(
"../data/proteome-fasta/C_albicans_GCF_000182965.3_ASM18296v3_protein.faa.gz"
"../data/proteome-fasta/C_glabrata_GCA_010111755.1_ASM1011175v1_protein.faa.gz"
"../data/proteome-fasta/GCF_002775015.1_Cand_auris_B11221_V1_protein.faa.gz"
"../data/proteome-fasta/S_cerevisiae_GCF_000146045.2_R64_protein.faa.gz"
)
names=("Calbicans" "Cglabrata" "Cauris" "Scerevisiae")

# https://unix.stackexchange.com/questions/278502/accessing-array-index-variable-from-bash-shell-script-loop
for ((idx=0; idx<${#files[@]}; ++idx)); do
	echo "Working on ${files[idx]}..."
	python ../script/calc_aafreq_gz.py ${files[idx]} | gzip -c > ../output/ST-freq/${names[idx]}-ST-freq.tsv.gz
	echo "done."
done
