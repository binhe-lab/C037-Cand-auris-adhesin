To cluster the CWP hits in the four _C. auris_ proteomes, the fasta file containing ~250 sequences were submitted to the [CD-hit webserver](http://weizhong-lab.ucsd.edu/cdhit-web-server/cgi-bin/)

`20210718-CD-hit-0.85`: -c 0.85
`20210718-CD-hit-0.6`: -c 0.6

To reformat the output, I wrote a script `../../script/format_cd-hit_output.py` and ran the following

```bash
python format_cd-hit_output.py ../output/cd-hit/20210718-CD-hit-0.85/1626635903.fas.1.clstr.sorted ../output/cd-hit/formatted-cd-hit-0.85.tsv
python format_cd-hit_output.py ../output/cd-hit/20210718-CD-hit-0.6/1626636351.fas.1.clstr.sorted ../output/cd-hit/formatted-cd-hit-0.6.tsv
```
