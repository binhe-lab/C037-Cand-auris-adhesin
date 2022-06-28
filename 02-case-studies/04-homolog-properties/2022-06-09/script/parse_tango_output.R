# title: parse tango output
# author: Bin He
# date: 2022-06-25
#       originally in an Rmarkdown file

# load library
require(tidyverse)

# input and output files
res.dir <- "../output/tango/"
out.file <- "../data/tango_summary_table.tsv.gz"
  
# function for parsing tango output files
extract_tango <- function(tango_output, agg_threshold = 5, required_in_serial = 5) {
    tmp <- read_tsv(file = tango_output, col_types = "icddddd") %>% 
        # a boolean vector for residues above threshold
        mutate(pass = Aggregation > agg_threshold)
    pass.rle <- rle(tmp$pass) # this creates a run length encoding that will be useful for identifying the sub-sequences in a run longer than certain length
    # --- Explanation ---
    # this rle object is at the core of this function
    # an example of the rle looks like
    #   lengths: int[1:10] 5 19 20 8 1 5 19 6 181 18
    #   values: logi[1:10] F T  F  T F T F  T F   T
    #   note that by definition the values will always be T/F interdigited
    # our goal is to identify the sub-sequences that is defined as a stretch of 
    # n consecutive positions with a score greater than the cutoff and record the
    # sub-sequence, its length, start and end position, 90% quantile of the score
    # --- End of explanation ---
    # 1. assigns a unique id for each run of events
    tmp$group <- rep(1:length(pass.rle$lengths), times = pass.rle$lengths)
    # 2. extract the subsequences
    agg.seq <- tmp %>% 
        filter(pass) %>% # drop residues not predicted to have aggregation potential
        group_by(group) %>% # cluster by the runs
        summarize(seq = paste0(aa, collapse = ""),
                  start = min(res), end = max(res), length = n(),
                  median = round(median(Aggregation), digits = 3),
                  q90 = quantile(Aggregation, probs = 0.9),
                  ivt = round(sum(aa %in% c("I","V","T")) / length(aa), digits = 3),
                  .groups = "drop") %>% 
        mutate(interval = start - lag(end) - 1) %>% 
        filter(length >= required_in_serial) %>% 
        select(-group)
    return(agg.seq)
}

tango.result.files <- list.files(path = res.dir, pattern = ".txt|.txt.gz", full.names = T)
# the read_csv() function used in the custom function can automatically decompress gzipped files
tango.res <- lapply(tango.result.files, extract_tango)
names(tango.res) <- gsub(".txt|.txt.gz", "", basename(tango.result.files))
tango.res.df <- bind_rows(tango.res, .id = "id")
# save the tango output
write_tsv(tango.res.df, out.file)
