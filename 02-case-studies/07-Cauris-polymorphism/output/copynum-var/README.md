## Goal
Determine tandem repeats copy number variation in the Hil family genes among _C. auris_ strains.

## Approach
Output from `tblastn` with either the NTD or full length protein sequence of XP_028889033. See `../../script/blast-full.sh` or `../../script/blast-NTD.sh` for detailed description of what each file is. I then loaded the aligned file `cauris-no-clade-ii-XP_028889033-full.aln.faa` into Jalview, added an additional XP_028889033 sequence on the top so I can import the annotation (in `../../input/XP_028889033_features.jalview`). After rearranging the sequences and coloring the amino acid residues using BLOSUM 62 scores, I opened up the overview window and took a screenshot of that, as it very nicely visualizes the deletions. Close up views of the deletions were then captured in the "wrapped" view. All figures are saved in this folder and linked to the `../figure/` folder or the other way around.

**Update 2021-11-07**
Extend the analysis to Hil2-4

### Download genome fna files
Added Clade II strains. See `../../input/genome-seq/README.md` for details

### Make blast database
```bash
cd ../../input/
cat genome-seq/*.gz | gunzip -c | makeblastdb -in - -parse_seqids -dbtype nucl -title Cand_auris_strains -out blastdb/Cand_auris_strains
```

### Perform tblastn
See `../../script/blast-{full,NTD}-Hil?.sh` for details.

### Assemble BED file to extract the sequences
Based on the tblastn results as shown in the README file in the parent folder, I assembled a BED file `Cauris-Hil-homologs-tblastn.bed` and installed `bedtools` to use its `getfasta` command to extract the sequences. `seqtk subseq` can do the same thing but doesn't allow for renaming the output files, while `bedtools` allows one to use the optional `name` field in the BED file to rename the extracted sequences. `bedtools` does require the input fasta file to be not compressed.

Several changes need to be made for the BED file
1. start must be smaller than the end, so for features on the minus strand, the `sstart` and `send` from tblastn output need to be swapped
1. strand information has to be explicitly encoded in BED file in the fifth column. 4th column is "score", which is not used but must be written (used 1)
1. BED is 0-based, so all start positions (the smaller number) need to go down by 1 from the tblastn output

```bash
# extract the nucleotide sequences using bedtools
bedtools getfasta -fi ../../input/genome-seq/all-cauris-strains.fna -bed Cauris-Hil-homologs-tblastn.bed -s -name -fo cauris-Hil-homologs-tblastn.fna
# edit the resulting fasta file by replacing "::" with " " so the next tool will properly deal with the sequence names
# translate to amino acid sequences using the yeast alternative nuclear code table using EMBOSS::transeq
transeq -table 12 -sequence cauris-Hil-homologs-tblastn.fna -outseq cauris-Hil-homologs-tblastn.faa
# convert the resulting fasta to a single line format using bioawk
bioawk -c fastx '{print ">"$name" "$comment; print $seq}' cauris-Hil-homologs-tblastn.faa >| cauris-Hil-homologs-tblastn.faa1
# examine the result and if satisfied, replace the previous file with the reformatted file
mv cauris-Hil-homologs-tblastn.faa1 cauris-Hil-homologs-tblastn.faa
```

### Write Hil1-4 homologs into fasta files
The goal here is to form four fasta files, one for each of Hil1-4. The basis would be the extracted and translated protein sequences from the previous step, but as some of the sequences there are incorrect (premature stop codons in sequences), I also used blast against the specific strain's genome to obtain the protein sequence directly from NCBI. My general approach is to copy and paste all protein sequences belonging to Hil1, for example, into clustalo website and align them. Note that B8441, which was used as the query strain, needs to be added. If the resulting alignment looks good, all sequences are directly copied to the new fasta file. If one or more sequences show large discrepancy, likely due to errors in the sequence and the ranges, I manually blast that strain's genome using the B8441 sequence query and identify the homolog. The sequence names in the resulting fasta files show which ones are from the previous extraction and which ones are from NCBI protein database.

### Align the Hil1-4 homologs
Used `clustao` locally

```bash
clustalo -i Hil1/Hil1-cauris-homologs.fasta --iter=5 -o Hil1/Hil1-cauris-homologs.faa
```

Visualize the results in Jalview, and created a Jalview project file to preserve the arrangement of the windows.

### XSTREAM detects tandem repeats and quantify the copy numbers
In order to quantify the number of tandem repeat copies, I used xstream with a modified substitution table (letting "V=I") to detect tandem repeats and it worked better than using the default table, because it allowed the GVVIVTT variants to properly align. The reason for using xstream to quantify the copy number is because it is tedious to manually count the copy number in the alignment. However, the xstream output needs to be carefully checked because different sequences may have slightly different consensus, starting and ending position. Therefore the result needs to be manually edited.

1. run `sh xstream-hil1-4.sh ../output/copynum-var/cauris-Hil-homologs-final.fasta cauris-Hil-homologs-sub ../output/tandem-repeats`
1. edit the `.xslx` file by renaming the headings and adding the "type" column, whose values comes from the first html file generated
1. import into R (see main analysis Rmd in the `07-Cauris-polymorphism` folder)
1. cross-reference the alignment output (second html output from xstream) and the alignment generated above to determine the copy numbers
