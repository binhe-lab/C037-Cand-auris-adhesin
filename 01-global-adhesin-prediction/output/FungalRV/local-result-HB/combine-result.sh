#!/bin/bash
# title: clean up and combine the local FungalRV output
# author: Bin He
# date: 2020-02-28
# modified: 2020-05-29 [HB] to add S. cerevisiae proteins
#
# desired headers:
#   <Species>	<Strain>	<ID>	<Score>
files=(C_albicans_GCF_000182965.3_ASM18296v3_protein.txt \
	   C_glabrata_GCF_000002545.3_ASM254v2_protein.txt \
	   GCA_003013715.2_Cand_auris_B11220_protein.txt \
	   GCA_002759435.2_Cand_auris_B8441_V2_protein.txt \
	   GCF_002775015.1_Cand_auris_B11221_V1_protein.txt \
	   S_cerevisiae_GCF_000146045.2_R64_protein.txt)
species=(C_albicans C_glabrata C_auris C_auris C_auris S_cerevisiae)
strains=(SC5314 CBS138 B11220 B8441 B11221 S288C)

# print header
echo "# FungalRV combined results"
echo "# 2020-05-29"
echo "# <Species>	<Strain>	<ID>	<Score>"

for i in {0..5};do
	awk -F "\t" -v sp="${species[$i]}" -v st="${strains[$i]}" \
		'BEGIN{OFS="\t"} /^>/{split($0,name," "); gsub(">","",name[1]); print sp,st,name[1],$2}' ${files[$i]}
done
