---
title: CATH prediction of protein domains 
author: Bin He
date: 2020-02-21
---

## 2020-02-21
At Jan's suggestion, Rachel and I looked into using [CATH](http://www.cathdb.info/search/by_sequence) to search for known protein domains.

My progress today is that I figured out how to use cURL and REST API to query the webapp with command line arguments. Based on the example given on their website ("API"), I tried the following commands:

1. follow their instructions to put one sequence at a time into a fasta file. note that the beginning of the sequence name must be "fasta=>SEQ_NAME". It seems there is a one sequence limit to use the webapp.
2. search
    ```bash
    $ id=$(curl -w "\n" -s -X POST -H 'Accept: application/json' --data-binary '@path/to/file.fasta' http://www.cathdb.info/search/by_funfhmmer | jq .task_id)
    # note, must include the @ symbol before the file path, and the file must conform to the format above
    # if the execution is successful, the website will return a json object with the sequence submitted and a task_id, e.g. b5b14d9ef2640c2d87a46d2968749861. This task id can then be captured using the json parser 'jq'
    ```
3. retrieve results
    ```bash
    $ curl -w "\n" -s -X GET -H 'Accept: application/json' http://www.cathdb.info/search/by_funfhmmer/results/$id | jq 
    ```
4. next
    a. study the output and decide what information to retrieve using `jq`

## 2020-02-22 Learn about CATH
- CATH :: stands for Class, Architecture, Topology, Homology. It is a hierarchical protein domain classification database. Protein structures are taken from the PDB, chopped into individual structural domains and then classified into superfamilies based on their evolutionary origin. CATH ID reflects the hierarchical classification, e.g. HLH DBD is classified as 4.10.280.10
- CATH FunFam :: stands for Functional Families, represents functionally coherent grouping of protein domain sequences within the CATH-Gene3D homologous superfamily.

## 2020-02-23 Follow the CATH authors' instructions to set up a genomewide scan
<https://github.com/UCLOrengoGroup/cath-tools-genomescan>
