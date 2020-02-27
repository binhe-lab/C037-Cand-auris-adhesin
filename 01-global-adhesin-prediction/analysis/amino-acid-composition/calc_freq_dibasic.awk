# calculate the frequencies of dibasic motifs
/KK|RR|KR|RK/ { freq+=$2;perc+=$3 } END{ print freq, perc }
