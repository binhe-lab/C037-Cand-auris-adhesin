# calculate the frequencies of dibasic motifs in protein sequences from a fasta file
# - this is the new version just using grep
# Bin He 2020-02-26
{
	cmd = "echo "$seq" | grep -o 'RR\\|KK\\|RK\\|KR' | wc -l"      	# assemble a bash command
		while ( ( cmd | getline res ) > 0 ){ print $name, res }	# run the command and collect output, if 
									# successful
}
