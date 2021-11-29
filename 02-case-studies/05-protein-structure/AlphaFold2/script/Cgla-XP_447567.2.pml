# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Cauris-Hil1-PF11765/20211031-AF2-Cauris-Hil1-PF11765/af2.pdb, Caur
load ../data/Cglabrata-XP_447567.2-PF11765/selected_prediction.pdb, Cgla

# align objects
align Cgla, Caur

# color the objects
color slate, Caur
color yelloworange, Cgla

# set view
set_view (\
		-0.258695900,    0.819447219,   -0.511454225,\
		0.954460621,    0.298297077,   -0.004841994,\
		0.148597181,   -0.489414275,   -0.859297991,\
		0.000000000,    0.000000000, -233.137725830,\
		-1.142829895,    0.461673737,   -1.043529510,\
		183.807556152,  282.467895508,  -20.000000000 )
### cut above here and paste into script ###

