# Folder content
| Folder | File name | Source | Date | Comments |
| ------ |-----------|--------|------|----------|
| proteome | *Cand_auris* proteome for B8441 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_002759435.2/) | 2019-10-15 | Scaffold, 18 |
| proteome | *Cand_auris* proteome for B11221 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_002775015.1/) | 2019-10-15 | Scaffold, 23 |
| proteome | *Cand_auris* proteome for B11220 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_003013715.2) | 2020-02-12 | Chromosome, 7 |
| proteome | *Cand_auris* proteome for B11243 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_003014415.1/) | 2019-10-15 | Scaffold, 238|
| proteome | *Cand_auris* proteome for B6684 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_001189475.1/) | 2019-10-15 | Scaffold, 99 |
| proteome | *Cand_glabrata* proteome for CBS138 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000002545.3) | 2020-02-10 | Rachel downloaded the current version of predicted proteins | 
| proteome | *Cand_glabrata* proteome for CBS138 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/protein?LinkName=bioproject_protein&from_uid=596126) | 2020-02-24 | Bin found a new genome release from the Cormack lab (note that this is CDS, i.e. DNA sequence) | 
| proteome | *Cand_glabrata* proteome for CBS138 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_010111755.1) | 2020-06-23 | This is the protein sequence from the new CBS138 genome sequenced by Cormack lab | 
| proteome | *Cand_albicans* proteome for SC5314 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000182965.3/) | 2020-02-10 | Rachel downloaded the current version of predicted proteins | 
| proteome | *Cand_pseudohaemulonii* proteome for B12108 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_003013735.1/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *Scheffersomyces stipitis* proteome for CBS 6054 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000209165.1/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *[Candida] duobushaemulonis* proteome for B09383 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_002926085.2/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *Meyerozyma guilliermondii* proteome for ATCC 6260 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000149425.1/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *[Candida] haemuloni* proteome for B11899 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_002926055.2/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *Debaryomyces hansenii* proteome for CBS767 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000006445.2/) | 2020-07-12 | Rachel downloaded proteome and assembly information |
| proteome | *Clavispora lusitaniae* proteome for ATCC 42720 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000003835.1/) | 2020-07-12 | Rachel downloaded proteome and assembly information |


# Notes
## 2020-02-12 New Cand_auris B11220 genome assembly
GCA_003013715.2 replaces GCA_003013715.1 as the latest chromosome level assembly. All analyses will be based on the new version

## 2020-02-24 New _C. glabrata_ genome
- New _C. glabrata_ genome sequence released last week, from Brendan Cormack's lab at JHU (pmid:32068314)
    - Bin downloaded the proteome by simply navigating to the bioproject page (PRJNA596126), based on the "data availability" section of the paper
    - From there, use the "Related Information"->"Protein" to get to all the protein sequences, select "Send to"->"File"->"FASTA" and download
    - Saved the output in `data/proteome`

## 2020-05-29 _S. cerevisiae_ added to the list
The rationale is to have a reference point especially when performing comparative analyses, where _C. glabrata_ is a distant relative of both _C. albicans_ and _C. auris_.
One quick note about the protein accession prefixes: most of the ref_protein accession # start with XP, but most _S. cerevisiae_ and a large proportion of _C. glabrata_ proteins start with NP. According to [ncbi](https://www.ncbi.nlm.nih.gov/books/NBK21091/table/ch18.T.refseq_accession_numbers_and_mole/?report=objectonly), the former represents proteins predicted from genome sequences (and gene models) that have various levels of homology support, while the latter is considered "curated" or experimentally supported, and thus are of higher quality. Only one strain of _C. auris_ receives the XP notation, while the rest uses special prefixes suggesting the evidence is not considered strong.
## 2020-06-23 New _C. glabrata_ protein, corrected
Back in February, I couldn't find the proper assembly. So instead I managed to use the "protein" link on the bioproject page to download the sequences. But I didn't realize that the file I downloaded, which is gzipped, is in fact CDS, i.e. DNA sequence. This time I found the proper assembly and was able to download the same format sequence as the other genomes. The file is renamed to make the species and strain names part of the file name.

