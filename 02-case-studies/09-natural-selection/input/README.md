input files for selection analysis. See main README in the parent folder for details

## Content
| name | description |
|--|--|
| repeats | (un)aligned repeat sequences |
| homologs | (un)aligned Hil homologs |
| BED | BED files for extracting parts of sequences |
| source | fasta files containing the source sequences for extracting |
| misc | Jalview annotation files, etc. to help with extraction |

## Some notes
The files are in groups that can be recognized by their names, e.g. `B8441-Hil-genes.*`. Below are some notes:

There are several groups of files that each contain two `BED` format files, one for the amino acid and the other for the nucleotide. These were used to extract individual repeat sequences as separate FASTA records using the `bedtools getfasta -fi INPUT -fo OUTPUT -name -bed BED`. The `BED` files were manually created using the information from the XSTREAM output for Hil1-Hil4 (check `../../07-Cauris-polymorphism/output/tandem-repeats/XSTREAM_cauris-Hil-homologs-sub_i0.7_g3_m5_L15_out_1.html`) and the protein sequences in `B8441-Hil-genes.faa`. For Hil1 and Hil2, the repeats are highly homogeneous in length. So I just used Jalview's "wrap" view to get their left and right limits, and manually entered them in Excel and saved the result as a tab delimited file (in the BED format). For Hil3 and Hil4, the lengths of the repeats are more variable. I found it is easier to first copy and paste the aligned repeat sequences into vim, remove the "-" characters, and then use `awk '{print length}' FILE` to count the length of each repeat. In Excel, I put in the left-most limit (-1, because `BED` is zero-based for the left limit, but 1-based for the right). Then the right limit is simply the left limit + length, which I record in the "Score" column of the BED file. To translate the amino acid BED to nucleotide, simply multiply the coordinates by 3 (this is the benefit of the 0-based coordinate system), and change the sequence name to match what's in the nucleotide sequence file `B8441-Hil-genes.fna`.

The `XP_028889033_541-1906.*` were my first attempt to extract the repeats. They are replaced by `B11221-Hil1-repeats*`.

`Hil-genes-CDS-collection.fna` is a file in which I attempted to collect the CDS sequences for the Hil homologs I needed for this analysis.

`GCA_002759435.2_Cand_auris_B8441_V2_cds_from_genomic.fna.gz` was used for retrieving the B8441 Hil homologs' CDS.
