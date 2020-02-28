# count cysteine content in amino acid sequences from a fasta file
# - this is the new version that uses grep
# Bin He 2020-02-27
{
	cmd = "echo "$seq" | grep -o 'C' | wc -l" 		# assemble a bash command
	while ( ( cmd | getline res ) > 0 ){ print $name, res }	# run the command and collect output, if successful
}
