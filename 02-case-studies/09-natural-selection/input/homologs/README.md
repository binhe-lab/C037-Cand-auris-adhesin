---
title: 
author: 
date: 
---

To extract the tandem repeat region for PAML
```bash
bioawk -c fastx '$name ~ /B8441|haemuloni/{print ">"$name;print substr($seq, 615, 1286)}' Hil1-2-MDR-full-clustalo.faa > Hil1-2-MDR-tr-clustalo-C615-1900.faa
bioawk -c fastx '$name ~ /B8441|haemuloni/{print ">"$name;print substr($seq, 1843, 3858)}' Hil1-2-MDR-full-clustalo.fna > Hil1-2-MDR-tr-clustalo-C1843-5700.fna
```
