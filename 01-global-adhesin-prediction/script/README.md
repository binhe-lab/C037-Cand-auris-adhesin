# List of scripts
| Item | Description | Source | Date |
| ---- | ----------- | ------ | ---- |
| extract_fasta.sh | shell script to extract fasta sequences based on a list of IDs | HB, custom | 2020-02-04 |
| FungalRV adhesin predictor | tools for predicting adhesins | http://fungalrv.igib.res.in/download.html | 2020-02-09 |
| R_fungalrv_fasta_filter_function | R script to extract and filter fasta files | RS, custom | 2020-02-11 |

# Notes
## 2020-02-10 Compiled and tested FungalRV code
Used the following command to compile the c files on my Ubuntu. Should be similar on other machines, too. If the binaries don't work on other systems, follow my example to compile the source c code.
```bash
# I assume you are in the FungalRV script folder, where the c source files are
for f in *.c;do gcc $f -o ./bin/${f/.c/}; done
```
Note that `FungalRV_adhesin_predictor/calc_hdr_comp.c` failed to compile.
