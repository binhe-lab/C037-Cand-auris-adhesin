## Note

I tried to use `raxml-ng` this time. `conda` could only install the 0.9.0 version, as the v1.1.0 seems to cause incompatibility issues with the existing libraries on the system. But since the newer version allows coarse-grained parallelization (not just across sites, but also with different "workers" to parallelize over the different bootstraps), I tried to compile the `raxml-ng-mpi` binary myself. I found that in order to compile the code, I had to temporarily `mv ~/sw/miniconda3 ~/sw/miniconda3-bk` to avoid the compiler seeing some of the conda installed tools. After that things went well. I used the default `stack/2021.1` on ARGON as of 2022-05-13, and loaded the following packages
```bash
module load cmake/3.20.0_gcc-9.3.0
module load gcc/9.3.0
module load openmpi/4.0.5_gcc-9.3.0
# while in the raxml-ng directory
./install.sh
```

**Update 2022-05-15**

I figured out how to get `conda` install the newer version of `raxml-ng` (and `generax`, as it turned out, required the same tweak). The issues are related to missing libraries, which apparently were not available from either the default `conda` or the `bioconda` channels. I need to additionally specify `-c conda-forge`, which solved the problem. In the process of troubleshooting this, I also learned about a project that is aimed at replacing `conda` called `mamba`, which is faster in resolving dependencies and provide more informative conflict reports.

## Script files 

| script file name | purpose |
|------------------|---------|
| align.sh | use either clustalo or hmmalign to align the sequences, then use ClipKIT to trit the alignment |
| raxml-ng.sh | using raxml-ng-mpi v1.1.0 to implement both coarse and fine-grained parallelization |
| raxmlng.sh | this uses the old v0.9.0 version of raxml-ng, only fine-grained parallelization |
| raxml.sh | this is the original standard raxml, using approximation for bootstrapping, but faster|
| run-generax.sh | use GeneRax to reconcile the gene tree with the species tree |