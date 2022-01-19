require(tidyverse)
require(seqinr)
# load the IDs
ID <- read_tsv("../input/BED/MDR-homologs-PF11765-aa.bed", col_names = c("name", "start", "end"))
# load the fasta downloaded from NCBI
seq.mdr <- read.fasta("../input/source/MDR-homologs-coding-sequence.fna", as.string = TRUE)
seq.auris <- read.fasta("../input/source/B8441-Hil-genes.fna", as.string = TRUE)
# rename the sequences for the Cauris to be compatible with the BED file
auris.names <- gsub("_Cauris", "_B8441_Cauris", names(seq.auris))
# rename the sequences for the MDR clade with the protein refseqID
mdr.names <- str_extract(names(seq.mdr), "XP_[0-9.]+")
# match the IDs to those used in the BED file
full.names <- ID %>% filter(grepl("XP_", name)) %>% pull(name)
names(full.names) <- str_extract(full.names, "XP_[0-9.]+")
final.names <- c(auris.names, full.names[mdr.names])
# write the renamed sequences
write.fasta(c(seq.auris, seq.mdr), final.names, file.out = "../input/source/MDR-homologs-cds-named-after-protein.fna", nbchar = 10000)