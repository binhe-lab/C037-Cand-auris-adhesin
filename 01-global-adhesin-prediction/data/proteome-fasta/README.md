| Folder | File name | Source | Date | Comments |
| ------ |-----------|--------|------|----------|
| proteome | *Cand_auris* proteome for B8441 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_002759435.2/) | 2019-10-15 | Scaffold, 18 |
| proteome | *Cand_auris* proteome for B11221 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_002775015.1/) | 2019-10-15 | Scaffold, 23 |
| proteome | *Cand_auris* proteome for B11220 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_003013715.2) | 2020-02-12 | Chromosome, 7 |
| proteome | *Cand_auris* proteome for B11243 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_003014415.1/) | 2019-10-15 | Scaffold, 238|
| proteome | *Cand_auris* proteome for B6684 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCA_001189475.1/) | 2019-10-15 | Scaffold, 99 |
| proteome | *Cand_glabrata* proteome for CBS138 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000002545.3) | 2020-02-10 | Rachel downloaded the current version of predicted proteins | 
| proteome | *Cand_glabrata* proteome for CBS138 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/protein?LinkName=bioproject_protein&from_uid=596126) | 2020-02-24 | Bin found a new genome release from the Cormack lab | 
| proteome | *Cand_albicans* proteome for SC5314 | [ncbi assembly](https://www.ncbi.nlm.nih.gov/assembly/GCF_000182965.3/) | 2020-02-10 | Rachel downloaded the current version of predicted proteins | 

# 2020-02-12 New Cand_auris B11220 genome assembly
GCA_003013715.2 replaces GCA_003013715.1 as the latest chromosome level assembly. All analyses will be based on the new version

# 2020-02-24 New _C. glabrata_ genome
- New _C. glabrata_ genome sequence released last week, from Brendan Cormack's lab at JHU (pmid:32068314)
    - Bin downloaded the proteome by simply navigating to the bioproject page (PRJNA596126), based on the "data availability" section of the paper
    - From there, use the "Related Information"->"Protein" to get to all the protein sequences, select "Send to"->"File"->"FASTA" and download
    - Saved the output in `data/proteome`
