# goal: prune the generax corrected gene tree for PAML
# author: Bin He
# date: 2022-01-16

require(ape)

# read tree
tree <- read.tree("../../07-Cauris-polymorphism/output/gene-tree/notung/GeneRax-corrected-gene-tree-20211206.newick")
# drop the clade II, III and IV strains of _C. auris_
drop <- grep("B11", tree$tip.label, value = TRUE)
tree.pruned <- drop.tip(tree, tip = drop)
# rename the B8441 sequence names
tree.pruned$tip.label <- gsub("Cauris.B8441", "B8441_Cauris", tree.pruned$tip.label)
# write the pruned tree
write.tree(tree.pruned, file = "../output/paml/MDR-PF11765-branch/GeneRax-corrected-tree-20211206-pruned.newick")

# just keep the B8441 sequences
keep <- grep("B8441", tree$tip.label, value = TRUE)
tree.B8441 <- keep.tip(tree, tip = keep)
tree.B8441$tip.label <- gsub("Cauris.B8441", "B8441_Cauris", tree.B8441$tip.label)
write.tree(tree.B8441, file = "../output/paml/B8441-Hil1-8-PF11765-branch/GeneRax-corrected-tree-20211206-pruned-B8441.newick")