# title: parse PfamScan JSON output
# date: 2022-04-26
# author: Bin He

require(tidyverse)
require(jsonlite)

# load data
dat <- read_json("../output/20220426-expanded-blast-pfam.json", simplifyVector = TRUE)

# reformat data
dat1 <- with(dat, tibble(
  seq_id = seq$name,
  alignment_start = seq$from,
  alignment_end = seq$to,
  envelope_start = env$from,
  envelope_end = env$to,
  hmm_acc = acc,
  hmm_name = name,
  hmm_start = hmm$from,
  hmm_end = hmm$to,
  hmm_length = model_length,
  bit_score = bits,
  Individual_e_value = evalue,
  database_significant = sig,
  clan = ifelse(clan == "No_clan", 0, 1)
))

# write the flattened tsv file
write_tsv(dat1, file = "../output/20220426-expanded-blast-pfamscan.tsv")
