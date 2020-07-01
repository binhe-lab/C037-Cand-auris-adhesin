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
  --  | match-id  | text  | 
  --  | score | double  | 
  --  | boundaries  | text  | 
  --  | resolved-boundaries | text  | 
  --  | cond-evalue | double  | 
  --  | indp-evalue | double  | 
  --  | start_1 | double  | 
  --  | end_1 | text  | 
  --  | start_2 | text  | 
  --  | end_2 | text  | 
  --  | tag_1 | text  | 
  --  | tag_2 | text  | 
  --  | tag_3 | text  | 
  --  | tag_4 | text  | 
  --  | tag_1_rep-protein | text  | 
  --  | tag_1_description | text  | 
  --  | tag_2_rep-protein | text  | 
  --  | tag_2_description | text  | 
  --  | tag_3_rep-protein | text  | 
  --  | tag_3_description | text  | 
  --  | tag_4_rep-protein | text  | 
  --  | tag_4_description | text  | 
