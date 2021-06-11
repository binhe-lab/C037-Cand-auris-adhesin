## Goal
Determine tandem repeats copy number variation in the Hil family genes among _C. auris_ strains.

## Approach
Output from `tblastn` with either the NTD or full length protein sequence of XP_028889033. See `../../script/blast-full.sh` or `../../script/blast-NTD.sh` for detailed description of what each file is. I then loaded the aligned file `cauris-no-clade-ii-XP_028889033-full.aln.faa` into Jalview, added an additional XP_028889033 sequence on the top so I can import the annotation (in `../../input/XP_028889033_features.jalview`). After rearranging the sequences and coloring the amino acid residues using BLOSUM 62 scores, I opened up the overview window and took a screenshot of that, as it very nicely visualizes the deletions. Close up views of the deletions were then captured in the "wrapped" view. All figures are saved in this folder and linked to the `../figure/` folder or the other way around.
