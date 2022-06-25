Use `tango2_3_1` to predict the beta-aggregation potential for Hil homologs. Some important steps and changes compared with previous analyses:

- `tango` doesn't allow non-amino-acid characters. I thus edited the `../../data/expanded-blast-homologs-edited-forFRV.faa` file, which was already rid of the "X" characters, to further remove the "*" at the end of the sequences.
- `tango` doesn't allow long sequence names. I copied the `../../../../00-shared/script/format_tango_batch.py` to the local `../../script/` folder and edited the `rsplit("_", 2)` function to remove the species name.
- after the above steps, I used `python format_tango_batch.py ../data/expanded-blast-homologs-edited-forFRV.faa ../output/tango/expanded-blast` to generate the script file, and ran it on ARGON with `qlogin`.
- for sequences that were part of the previous 104 homologs, I compared their results with the previous ones and they appear to be identical. Nonetheless, I added all the new results to the repo.
