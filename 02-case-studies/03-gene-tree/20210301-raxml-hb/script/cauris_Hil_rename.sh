#! /bin/bash
# title: edit the IDs of the C. auris Hil homologs in a file by 
#        appending the Hil1-8 synonym
# date: 2021-11-23
# author: Bin He

set -eo pipefail

sed -i bak \
	-e 's/XP_028892087/Hil5_&/g'\
	-e 's/XP_028887965/Hil6_&/g'\
	-e 's/XP_028889034/Hil8_&/g'\
	-e 's/XP_028888611/Hil2_&/g'\
	-e 's/XP_028889033/Hil1_&/g'\
	-e 's/XP_028892406/Hil3_&/g'\
	-e 's/XP_028889361/Hil7_&/g'\
	-e 's/B9J08/Hil4_&/g'\
	$1
