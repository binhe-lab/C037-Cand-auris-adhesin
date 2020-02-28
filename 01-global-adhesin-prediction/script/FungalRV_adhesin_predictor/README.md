---
title: FungalRV prediction tool
author: Bin He
date: 2020-02-10
---
# Notes
## 2020-02-10 Compiled and tested FungalRV code
Used the following command to compile the c files on my Ubuntu. Should be similar on other machines, too. If the binaries don't work on other systems, follow my example to compile the source c code.

```bash
# I assume you are in the FungalRV script folder, where the c source files are
for f in *.c;do gcc $f -o ./bin/${f/.c/}; done
```

Note that `FungalRV_adhesin_predictor/calc_hdr_comp.c` failed to compile.

## 2020-02-19 Solved error in compiling one of the FungalRV code
Error:
> undefined reference to `pow'
> error: ld returned 1 exit status

This [link](https://stackoverflow.com/questions/12824134/undefined-reference-to-pow-in-c-despite-including-math-h) solved the problem.

`gcc calc_hdr_comp.c -o bin/calc_hdr_comp -lm`

## 2020-02-28 Downloaded SVM light and the standalone is now functional
Download the Mac OS new verison from the author's [website](http://download.joachims.org/svm_light/current/svm_light_osx.8.4_i7.tar.gz), untarred the file and just moved the `svm_classify` in the current folder. Note that if someone wants to run the program, s/he will likely need to download the version of `svm_classify` suitable for the OS, and may need to recompile the C source files.

Wrote a wrapper script `batch-fungalrv-predict.sh` to process all genome files. Two genomes threw a lot of errors, one of which is _C. albicans_. I unzipped the protein file and uploaded onto the FungalRV web app, and processed there. Among 6030 sequences, 5971 were successfully processed, with 231 above the threshold of 0. I downloaded the results and replaced the script output. The output files were moved to `output/FungalRV/local-result-HB/`, while the log and error files were not committed to the repository.
