# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Cauris-Hil1-PF11765/20211031-AF2-Cauris-Hil1-PF11765/af2.pdb

# load library
# import psico.editing

# use dssp to assign secondary structure
# dssp

# reproduce the confidence score based coloring, e.g. https://www.uniprot.org/uniprot/Q5AL03#structure
select very_high, b>90
select high, b>70 AND b<90.01
select low, b>50 AND b<70.01
select very_low, b<50.01

color 0x0053D6, very_high
color 0x65CBF3, high
color 0x0053D6, low
color 0xFF7D45, very_low

# set view
set_view (\
		-0.211410463,    0.763770342,   -0.609887183,\
		0.935502410,    0.338852108,    0.100068115,\
		0.283090264,   -0.549395144,   -0.786146760,\
		0.000000000,    0.000000000, -233.137725830,\
		-1.142829895,    0.461673737,   -1.043529510,\
		183.807556152,  282.467895508,  -20.000000000 )
### cut above here and paste into script ###

scene long, store
ray 1400, 2000
png ../output/20211031-AF2-Cauris-Hil1-PF11765-longitudinal.png
