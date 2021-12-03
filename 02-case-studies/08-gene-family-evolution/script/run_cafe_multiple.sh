#!shell
date
version

#specify data file, p-value threshold, # of threads to use, and log file
load -i ../input/gene-families-input.txt -p 0.01 -t 6 -l ../output/log.txt

#the phylogenetic tree structure with branch lengths
tree (((Sstipitis:102.0371,((Ctropicalis:39.4542,(Calbicans:8.7267,Cdubliniensis:8.7267):30.7275):20.3422,(Lelongisporus:36.7434,Cparapsilosis:36.7433):23.053):42.2407):42.93,(Cauris:105.3573,Clusitaniae:105.3572):39.6097):90.085,((((Nbacillisporus:74.5369,(Cglabrata:37.8238,(Nbracarensis:17.5709,(Ndelphensis:12.7004,Nnivariensis:12.7004):4.8705):20.253):36.7131):7.1351,(Smikatae:8.304,(Scerevisiae:4.9056,Sparadoxus:4.9056):3.3985):73.368):4.9796,Ncastellii:86.6516):27.3479,Klactis:113.9994):121.0527)

#search for a multiple parameter model
lambda -s -t (((1,((2,(2,2)2)2,(1,1)1)1)1,(2,2)2)1,((((1,(1,(1,(1,1)1)1)1)1,(1,(1,1)1)1)1,1)1,1)1)

# generate a report
report ../output/multiple-lambda
