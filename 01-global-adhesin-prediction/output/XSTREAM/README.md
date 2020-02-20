## 20 February 2020

Added XSTREAM tandem repeat finder output
- XSTREAM was chosen among various other protein tandem repeat finders due to its [flexibility](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-382), speed, and its ability to be downloaded and not enter the proteins sequence by sequence
- XSTREAM was downloaded [here](https://amnewmanlab.stanford.edu/xstream/download.jsp)
- A text file of all predicted adhesins was inputted into XSTREAM with the following parameters: Min Word Match = 0.7, Min Cons Match = 0.8, Max Indel Err = 0.5, Max Gaps = 3, Min Period = 2, Max Period = - , Min Copy # = 2.0, Min TR Domain = 10, Remove Overlap = true, Merge TR Domains = true
  - These are the suggested/default values
  - Output is 3 html files and a MS Excel document. Both are included in the folder. The first html file links to the other two, and shows where the same tandem repeat pattern is found multiple times in one protein or in multiple proteins.
  - Output also split and saved as .txt files by species
 - Number of tandem repeat patterns found in each protein was counted and recorded in tango_xstream_results.txt
