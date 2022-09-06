# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/7o9q.cif

# remove chain B and focus on chain A
remove chain B
center

# remove water
hide nonbonded

# remove the organic solvent
remove organic

# create domain selections
select beta-helix, resi 18-240
select alpha-crystallin, res 241-340
deselect

# color by domain
color 0x0053D6, beta-helix
color slate, alpha-crystallin
#color limegreen, beta-helix
#color limon, alpha-crystallin

# labeling the β-strands
set label_size, -3.5
set label_font_id, 10

label 26/CA, u"\u03b22"
label 44/CA, u"\u03b25"
label 67/CA, u"\u03b28"
label 94/CA, u"\u03b211"
label 122/CA, u"\u03b214"
label 150/CA, u"\u03b217"
label 184/CA, u"\u03b220"
label 205/CA, u"\u03b223"
label 224/CA, u"\u03b226"

label 253/CA, u"\u03b229"
label 263/CA, u"\u03b230"
#set label_color, firebrick, 263/CA
label 270/CA, u"\u03b231"
#set label_color, firebrick, 270/CA
label 280/CA, u"\u03b232"
#set label_color, firebrick, 280/CA
label 294/CA, u"\u03b233"
label 309/CA, u"\u03b234"

# set view
set_view (\
		0.023214670,    0.802729487,    0.595889568,\
		-0.993730605,    0.083732240,   -0.074080147,\
		-0.109359384,   -0.590434134,    0.799642503,\
		0.000000000,    0.000000000, -206.543273926,\
		1.943479538,   43.054481506,   39.996742249,\
		162.840286255,  250.246261597,  -20.000000000 )

# set_view (\
# 		0.552923679,    0.268756509,    0.788698196,\
# 		-0.167929485,    0.963072956,   -0.210446939,\
# 		-0.816135228,   -0.016084863,    0.577638090,\
# 		0.000000000,    0.000000000, -206.543273926,\
# 		1.943479538,   43.054481506,   39.996742249,\
# 		162.840286255,  250.246261597,  -20.000000000 )
# end set view

scene long, store
ray 2000, 1400
png ../output/20220902-Cgla-Awp1-long.png
