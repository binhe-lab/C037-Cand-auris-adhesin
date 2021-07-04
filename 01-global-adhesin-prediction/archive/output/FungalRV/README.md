# January 29, 2020 Predicted adhesins with FungalRV
1. Divided proteome fasta file into two by the following command split -l #oflines filename
2. Submit the split files to [FungalRV](http://fungalrv.igib.res.in/query.php) No parameters are needed for this tool. PMID: 21496229
3. Output saved as fasta files
# June 4, 2020 Added _S. cerevisiae_ predicted adhesin sequences
```bash
$ find . -iname "*_filtered.fasta" -exec cat {} >> all_fungalRV_predicted_adhesins.fasta \;
