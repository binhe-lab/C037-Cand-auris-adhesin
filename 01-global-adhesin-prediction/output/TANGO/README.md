## 20 February 2020

Added TANGO results for each species
- Downloaded TANGO to run locally from [here](http://tango.crg.es/)
- Perused papers by the group who wrote TANGO to determine reasonable screening parameters [here](https://www.nature.com/articles/s41467-018-03131-0#Sec11) and [here](https://www.nature.com/articles/nbt1012#Sec14) as well as the documentation [here](http://tango.crg.es/Tango_Handbook.pdf)
- Created a .bat to run all of the adhesin sequences through TANGO with the parameters: nt="N"ct="N" ph="7.5" te="298" io="0.1" tf="0" stab="-10" conc="1"
  - .bat is posted in the scripts folder
- TANGO outputs a file for each input file. I loaded all of them into R, screened for aggregation where Aggregation liklihood percent > 5 for 5 or more amino acids in a row and counted occurances that satisfied these criteria in each sequence
  - Same screening method recommended in papers above
  - R function for this in the scripts folder
  - Results in tango_xstream_results.txt under column agg_seqs
