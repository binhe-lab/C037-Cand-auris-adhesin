# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Cauris-Hil1-PF11765/20211031-AF2-Cauris-Hil1-PF11765/af2.pdb, CaurHil1

# remove water
hide nonbonded

# create domain selections
select beta-helix, resi 1-224
select alpha-crystallin, res 225-300
select c-term, res 301-316
hide everything, c-term

deselect
center

# color by domain
color 0x0053D6, beta-helix
color slate, alpha-crystallin
#color limegreen, beta-helix
#color limon, alpha-crystallin

# labeling the β-strands
set label_size, -2.8
set label_font_id, 10

label 18/CA, u"\u03b22"
label 39/CA, u"\u03b25"
label 59/CA, u"\u03b28"
label 84/CA, u"\u03b211"
label 111/CA, u"\u03b214"
label 138/CA, u"\u03b217"
label 165/CA, u"\u03b220"
label 184/CA, u"\u03b223"
label 207/CA, u"\u03b225"

label 242/CA, u"\u03b228"
label 252/CA, u"\u03b229"
label 257/CA, u"\u03b230"
label 270/CA, u"\u03b231"
label 282/CA, u"\u03b232"
label 294/CA, u"\u03b233"

# set view
set_view (\
		-0.360295683,    0.932833612,   -0.001054661,\
		-0.027584348,   -0.009521560,    0.999573588,\
		0.932426393,    0.360173464,    0.029162580,\
		0.000000000,    0.000000000, -233.137725830,\
		-1.142829895,    0.461673737,   -1.043529510,\
		183.807556152,  282.467895508,  -20.000000000 )
# end set view

scene long, store
ray 2000, 1400
png ../output/20220902-Caur-Hil1-long.png
