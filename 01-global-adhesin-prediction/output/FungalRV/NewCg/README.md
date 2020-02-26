# 25 Feb 2020
- New _C. glabrata_ genome sequence released last week, from Brendan Cormack's lab at JHU (pmid:32068314)
- Bin downloaded the proteome by simply navigating to the bioproject page (PRJNA596126), based on the "data availability" section of the paper
    - From there, use the "Related Information"->"Protein" to get to all the protein sequences, select "Send to"->"File"->"FASTA" and download
    - Saved the output in `data/proteome`
- Lindsey submitted the new fasta file to FungalRV on 2020-02-25, using the default score cutoff > 0, and discovered >1000 predicted adhesins!

HB: I suspect the protein sequences are not of the same length for some reason. To check this, I did the following

1. Use [bioawk](https://github.com/vsbuffalo/bioawk-tutorial) to get the lengths of proteins from both the old and new protein sequences.
    ```bash
    $ bioawk -c fastx '{print $name, length($seq)}' C_glabrata_CBS138_new_genome_release_20200224_protein.faa | sort -k2 > NewCg-protein-length.txt
    $ bioawk -c fastx '{print $name, length($seq)}' C_glabrata_GCF_000002545.3_ASM254v2_protein.faa.gz | sort -k2 > OldCg-protein-length.txt
    ```
1. Import the length in R and get the summary statistics
    ```r
    > require(data.table)
    > newL <- fread("NewCg-protein-length.txt", sep = "\t")
    > oldL <- fread("OldCg-protein-length.txt", sep = "\t")
    > fivenum(newL$V2)
    [1]   105   759  1263  1944 21711
    > fivenum(old$V2)
    [1]   34    255   420   646  4880
    #    min    25%  median 75%   max
    ```

As one can see, the differences are huge. I need to make the correspondence between the IDs to figure out what's different between them. I bet there is some simple explanation for the disagreement. I'll leave it here for now.
