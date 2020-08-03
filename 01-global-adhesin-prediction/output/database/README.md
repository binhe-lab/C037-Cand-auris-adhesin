## Files

File | Description
-- | -- |
adhesin_analysis.db | database file for use in R with package RSQLite
upload_tables.xlsl | Excel file containing most tables uploaded into R for initial instance of adhesin_analysis.db


## To use database file in R

Put the database file "adhesin_analysis.db" in the home directory for your R project and use conn <- dbConnect(RSQLite::SQLite(), "adhesin_analysis.db")

## Database tables, fields, types, and descriptions

Table | Field | Field Type  | Field Description
--  | --  | --  | --  |
fasta | short_string  | text  | protein identifier
 -- | species | text  | species to which protein belongs
 -- | strain  | text  | strain of species sequenced
 -- | sequence  | text  | sequence of protein in question
 -- | aa_length | double  | sequence length in amino acids
 -- | description | text  | fid description text
 fungal_rv  | short_string  | text  | protein identifier
 -- | frv_score | text  | fungal rv score
  faapred  | short_string  | text  | protein identifier
  --  | faa_score | double  | FaaPred score
  --  | faa_decision  | text  | "Adhesin" or "Non-adhesin" based on faa_score cutoff -0.8
  phobius  | short_string  | text  | protein identifier
  --  | num_transmembrane | double  | number of predicted transmembrane segments
  --  | signal_peptide_pred | int | 1/0 indicator if a signal peptide was predicted or not
  --  | topology_pred | text  | predicted topology of the protein
  gpi_som  | short_string  | text  | protein identifier
  --  | cleavage_site | text  | best match for cleavage site
  --  | gpi_anchored  | int | 1/0 indicator if protein is predicted to be GPI anchored - all in table are 1
  tango_protein | short_string  | text  | protein identifier
  --  | num_agg_seqs  | double  | number of predicted aggregation sequences in protein
  --  | longest_agg_seq | double  | length of longest aggregation sequence predicted in protein
  tango | short_string  | text  | protein identifier
  --  | sequence  | text  | sequence of predicted aggregation section
  --  | start | int | amino acid number of start of aggregation sequence in protein
  --  | end | int | amino acid number of end of aggregation sequence in protein
  --  | max | double  | maximum aggregation score within aggregation section
  --  | size  | double  | length of aggregation segment in amino acids
  --  | interval  | int | interval between current aggregation segment and previous in protein; will be NULL for the first aggregation segment in each protein
  xstream | short_string  | text  | protein identifier
  --  | start | double  | amino acid number of start of tandem repeat sequence in protein
  --  | end | double  | amino acid number of end of tandem repeat sequence in protein
  --  | length  | double  | length of tandem repeat segment in amino acids
  --  | period  | double  | period of tandem repeat - how many amino acids make up the actual repeat
  --  | num_copy  | double  | number of copies of the tandem repeat in the tandem repeat segment
  --  | multi_seq_align | text  | multiple sequence alignment of tandem repeats in the segment - repeats differentiated by white space
  --  | consensus_no_gap  | text  | consensus sequence of tandem repeat without gaps
  --  | consensus_gap  | text  | consensus sequence of tandem repeat with gaps
  --  | consensus_error | double  | multiple sequence alignment error of the consensus sequence
  cath | short_string  | text  | protein identifier
  --  | match-id  | text  | CATH ID of database structural match
  --  | score | double  | score for database structural match
  --  | boundaries  | text  | boundaries of match, unresolved
  --  | resolved-boundaries | text  | boundaries of match, resolved so that no structural domains may overlap - higher scoring domain seems to be assigned any overlapping amino acids
  --  | cond-evalue | double  | conditional e-value of match
  --  | indp-evalue | double  | independent e-value of match
  --  | start_1 | double  | amino acid number of start of first domain match
  --  | end_1 | text  | amino acid number of end of first domain match
  --  | start_2 | text  | amino acid number of start of second domain match, if same domain is in protein at multiple positions
  --  | end_2 | text  | amino acid number of end of second domain match, if same domain is in protein at multiple positions
  --  | tag_1 | text  | first hierarchical level CATH group
  --  | tag_2 | text  | second hierarchical level CATH group
  --  | tag_3 | text  | third hierarchical level CATH group
  --  | tag_4 | text  | fourth hierarchical level CATH group
  --  | tag_1_rep-protein | text  | CATH id for representative protein of first hierarchical level CATH group
  --  | tag_1_description | text  | structural description of first hierarchical level CATH group
  --  | tag_2_rep-protein | text  | CATH id for representative protein of second hierarchical level CATH group
  --  | tag_2_description | text  | structural description of second hierarchical level CATH group
  --  | tag_3_rep-protein | text  | CATH id for representative protein of third hierarchical level CATH group
  --  | tag_3_description | text  | structural description of third hierarchical level CATH group
  --  | tag_4_rep-protein | text  | CATH id for representative protein of fourth hierarchical level CATH group
  --  | tag_4_description | text  | structural description of fourth hierarchical level CATH group
  hmm_pfam | short_string  | text  | protein identifier
  --  | pfam_id | text  | pfam identification name of identified domain
  --  | pfam_accession | text  | pfam accession number of identified domain
  --  | pfam_clan | text  | name of pfam clan of identified domain
  --  | pfam_description | text  | description of identified domain
  --  | start_position| integer  | starting amino acid number of identified domain in protein
  --  | end_position | integer  | ending amino acid number of identified domain in protein
  --  | indp_e_value | text  | independent e-value of domain match to protein
  --  | cond_e_value | text  | conditional e-value of domain match to protein
