# count cysteine content in amino acid sequences from a fasta file
# - this is a bioawk program that calls another awk program, not recommended, but gets things done...
# Bin He 2020-02-26
{
	cmd = "echo "$seq" | compseq -filter -word 1 | awk -f calc_freq_cys.awk" # assemble a bash command
	while ( ( cmd | getline res ) > 0 ){ print $name, res }                  # run the command and collect 
										 # output, if successful
}
