# Content
This folder contains additional genome sequences for _C. auris_ strains.

# Method
Based on the NCBI [recommendation](https://www.ncbi.nlm.nih.gov/genome/doc/ftpfaq/#downloadservice), I went to the [NCBI assembly page](https://www.ncbi.nlm.nih.gov/assembly), searched for _C. auris_, and then based on Muñoz _et al._ 2021 Genetics selected all the genomes except those in clade II, and clicked "Download assemblies" on top of the search result page. I didn't include Clade II strains because the Muñoz paper has shown that they don't have the homolog of XP_028889033. Except for B11221, all other _C. auris_ genomes at the time of this writing are "GenBank" assemblies. Most of them don't have annotations yet. So I just downloaded the "genomic fasta (.fna)" files. The downloaded files are extracted and gzipped for storage.

# Notes
## 2021-04-28 [HB] Clade I, III and IV
Clade I: B8441, B11205, B13916
Clade III: B11221, B12037, B12631, B17721.
Clade IV: B11245, B12342

## 2021-11-06 [HB] Add Clade II strains
Clade II: B11220, B12043, B11809, B13463

As I'm going to extend the copy number variation analysis to Hil2-4, I'll need the Clade II strains as well. The download method above didn't work as the list from the Assembly search using "Candida auris" as query didn't show the Clade II strain names. Instead I searched each strain's name directly and downloaded each of their fna file individually.
