| Folder | Content | Comments |
| ------ | ------- | -------- |
| XP_028889033_query.fasta | query sequences for blast | contains two sequences: 1)full length; 2) PF11765 domain|
| Cauris-strains | proteome sequences of _C. auris_ strains | See README therein |
| GRYC | blastp against the Genome Resources for Yeast Chromosomes (GRYC) | http://gryc.inra.fr/ |
| assembly-info | assembly information downloaded from NCBI assembly database | NA |
| blastdb | blast database for local blast | NA |
| fungidb | blastp against FungiDB database | https://fungidb.org |
| ncbi-nr | blastp against the NCBI nonredundant protein database | NA |
| ncbi-refseq | blastp against the NCBI refseq_protein database | NA |
| expanded-blast | blastp with two more queries | in response to reviewer comments |
| yeast-phylogeny | species that are included in the Shen et al 2018,2020 phylogeny | for selecting blast hits to include for later analysis |
| s_stipitis_assembly | GCA_016859295.1 2020 genome assembly | for identifying full length products in the species |
| c_glabrata_CBS138 | GCA_010111755.1 2020 genome assembly | for identifying full length products in the species |
| c_glabrata_BG2 | GCA_014217725.1 genome assembly | for identifying full length products in the species |

Explanations for some of the files in the subfolders above:

# Content

| File                                                       | Description                                                  | Source                                                       | User/Date |
| ---------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | --------- |
| XP_028889033_homologs_fungidb.fasta                        | New blast results, 95 sequences                              | fungidb, see notes below                                     | HB/2020   |
| XP_028889033_homologs_fungidb_table.tsv                    | Accompanying meta data for the file above                    | fungidb                                                      | HB/2020   |
| XP_028889033_homologs_fungidb_use.fasta                    | filtered list with length > 500, 82 sequences                | fungidb, see notes below                                     | HB/2020   |
| XP_028889033_fungidb-refprot-blast.txt                     | fungiDB hits blasted against the refseq_protein database to identify matching sequences | NCBI BLAST                                                   | HB/2020   |
| XP_028889033_homologs_refprot_N560.fasta                   | XP_028889033 first 560 aa blast against refseq_protein database | NCBI refseq_protein                                          | HB/2020   |
| XP_028889033_homologs_refprot_N560_select.fasta            | XP_028889033 first 560 aa blast against refseq_protein database, some species removed, see notes above | NCBI refseq_protein                                          | HB/2020   |
| XP_028889033_homologs_refprot_N560.gb.gz                   | "Download" in Genbank format                                 | NCBI BLAST                                                   | HB/2020   |
| XP_028889033_homologs_refprot_N560_hit_tab.txt             | Hit list in CSV format                                       | NCBI BLAST                                                   | HB/2021   |
| XP_028889033_homologs_refprot_length_N560.txt              | protein length                                               | `bioawk -c fastx '{print $name, length($seq)}' XP_028889033_homologs_refprot.fasta` | HB/2020   |
| XP_028889033_homologs_refprot_N360.fasta                   | XP_028889033 first 360 aa blast against refseq_protein database, fasta sequences | NCBI refseq_protein                                          | HB/2021   |
| XP_028889033_homologs_refprot_N360.csv                     | XP_028889033 first 360 aa blast against refseq_protein database, hit table in CSV | NCBI refseq_protein                                          | HB/2021   |
| XP_028889033_homologs_refprot_N360_hit_tab.txt             | Hit list in CSV format                                       | NCBI BLAST                                                   | HB/2021   |
| XP_028889033_homologs_refprot_length_N560.txt              | protein length                                               | `bioawk -c fastx '{print $name, length($seq)}' XP_028889033_homologs_refprot.fasta` | HB/2020   |
| XP_028889033_homologs_gryc.fasta                           | blast identified homologs in the Nakaseomyces group          | [GRYC](http://gryc.inra.fr/index.php)                        | HB/2020   |
| XP_028889033_homologs_gryc_blastp.out                      | accompanying blast alignment output for the above file       | GRYC                                                         | HB/2020   |
| XP_028889033_homologs_gryc_table.txt                       | accompanying meta data for the above file                    | GRYC html, manually edited                                   | HB/2020   |
| 20200704-ncbi-blastp-XP_028889033-taxonmy-distribution.png | screenshot of the taxonomy distribution of the above blast result | NCBI blast                                                   | HB/2020   |
| 20200701-XP_028889033-homologs-e-value-by-length.png       | plot protein length by e-value                               | see `blast.Rmd` for details                                  | HB/2020   |
| blast.* and fungidb_*                                      | script and intermediate files for merging the blast hits     | see `blast.Rmd` for details                                  | HB/2020   |
