# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/5ny0.cif

# remove chain B and focus on chain A
# remove chain B
center
dss

# remove water
hide nonbonded

# create domain selections
#select beta-helix, resi 18-240
#select alpha-crystallin, res 241-340
#deselect

# color by domain
color 0x0053D6, 5ny0
#color limegreen, 5ny0
color yelloworange, ss h

# labeling the β-strands
set label_size, -2.5

#label 26/CA, u"\u03b22"
#label 44/CA, u"\u03b25"
#label 67/CA, u"\u03b28"
#label 94/CA, u"\u03b211"
#label 122/CA, u"\u03b214"
#label 150/CA, u"\u03b217"
#label 184/CA, u"\u03b220"
#label 205/CA, u"\u03b223"
#label 224/CA, u"\u03b226"

#label 253/CA, u"\u03b229"
#label 263/CA, u"\u03b230"
#set label_color, firebrick, 263/CA
#label 270/CA, u"\u03b231"
#set label_color, firebrick, 270/CA
#label 280/CA, u"\u03b232"
#set label_color, firebrick, 280/CA
#label 294/CA, u"\u03b233"
#label 309/CA, u"\u03b234"

# set view
set_view (\
		0.234650448,   -0.535736799,   -0.811125040,\
		-0.177380860,    0.796814382,   -0.577600300,\
		0.955757082,    0.279410481,    0.091945022,\
		0.000000000,    0.000000000, -176.154403687,\
		-2.461526871,   27.832292557,   50.564228058,\
		-814.140319824, 1166.449218750,  -20.000000000 )
# end set view

# scene long, store
ray 2000, 1400
png ../output/20220902-Lreu-SRRP-BR-long.png
