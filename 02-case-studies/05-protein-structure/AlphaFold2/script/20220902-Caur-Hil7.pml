# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Cauris-Hil7-PF11765/20211031-AF2-Cauris-Hil7-PF11765/af2.pdb, CaurHil7

# remove water
hide nonbonded

# create domain selections
select beta-helix, resi 1-222
select alpha-crystallin, res 223-300
select c-term, res 301-316
hide everything, c-term

deselect
center

# color by domain
color 0x0053D6, beta-helix
color slate, alpha-crystallin

# labeling the β-strands
set label_size, -2.8
set label_font_id, 10

label 18/CA, u"\u03b22"
label 39/CA, u"\u03b25"
label 59/CA, u"\u03b28"
label 84/CA, u"\u03b211"
label 110/CA, u"\u03b214"
label 137/CA, u"\u03b217"
label 164/CA, u"\u03b220"
label 183/CA, u"\u03b223"
label 205/CA, u"\u03b225"

label 240/CA, u"\u03b228"
label 250/CA, u"\u03b229"
label 255/CA, u"\u03b230"
label 268/CA, u"\u03b231"
label 280/CA, u"\u03b232"
label 292/CA, u"\u03b233"

# set view
set_view (\
		-0.616414964,    0.787339985,    0.010980277,\
		0.304958940,    0.225854605,    0.925196350,\
		0.725964725,    0.573654950,   -0.379326671,\
		0.000000000,    0.000000000, -233.137725830,\
		-1.142829895,    0.461673737,   -1.043529510,\
		183.807556152,  282.467895508,  -20.000000000 )
# end set view

scene long, store
ray 2000, 1400
png ../output/20220902-Caur-Hil7-long.png
