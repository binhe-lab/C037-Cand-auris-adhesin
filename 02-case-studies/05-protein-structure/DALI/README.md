## Content
| Folder | Date | Description |
| ------ | ---- | ----------- |
| 1RWR-5NY0 | 2021-05-12 | compare two bacterial adhesins structures, which were respectively identified as the top templates for _C. auris_ Hil1 and _C. albicans_ Hyr1 |
| Calb-Caur-Cgla-Klac | 2021-11-23 | compare the predicted structures for the PF11765 domains in four distantly related Hil homologs |
| CaurHil1-PDB | 2022-09-20 | compare the predicted PF11765 structure for Caur Hil1 in PDB50 |

## Analysis
DALI output doesn't include the "structural keywords" field from RCSB, which identifies most of the adhesins with the "CELL ADHESION" keyword. To programmatically pull out this information, I installed the [pypdb](https://github.com/williamgilpin/pypdb) package and wrote a `CaurHil1-PDB/20220922-search-rcsb-attrib.ipynb` to extract that information.
