#!/bin/bash
# title: clean up and combine the local FungalRV output
# author: Bin He
# date: 2020-02-28
# modified: 2020-05-29 [HB] to add S. cerevisiae proteins
# modified: 2020-06-23 [HB] edited to be used for individual species
#
# desired headers:
#   <Species>	<Strain>	<ID>	<Score>

set -eo pipefail
if [ $# -ne 3 ]
then
	echo "sh process-fungalrv-output.sh <INPUT-FILE> <SPECIES-NAME> <STRAIN-ID>"
	exit
fi

files=$1
species=$2
strains=$3

# print header
echo "# <Species>	<Strain>	<ID>	<Score>"

awk -F "\t" -v sp="${species}" -v st="${strains}" \
	'BEGIN{OFS="\t"} /^>/{split($0,name," "); gsub(">","",name[1]); print sp,st,name[1],$2}' ${files}
