# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Cauris-Hil1-PF11765/20211031-AF2-Cauris-Hil1-PF11765/af2.pdb, Hil1
load ../data/Cauris-Hil7-PF11765/20211031-AF2-Cauris-Hil7-PF11765/af2.pdb, Hil7

# align objects
align Hil7, Hil1

# view side by side
set grid_mode, 1
set grid_slot, 1, Hil1
set grid_slot, 2, Hil7

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
		-0.258695900,    0.819447219,   -0.511454225,\
		0.954460621,    0.298297077,   -0.004841994,\
		0.148597181,   -0.489414275,   -0.859297991,\
		0.000000000,    0.000000000, -233.137725830,\
		-1.142829895,    0.461673737,   -1.043529510,\
		183.807556152,  282.467895508,  -20.000000000 )
### cut above here and paste into script ###

scene long, store
ray 1000, 800
png ../output/20211031-AF2-Cauris-Hil1-Hil7-PF11765-longitudinal.png, dpi=300
