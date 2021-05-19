# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/S615682_results/model1.pdb

# load library
import psico.editing

# use dssp to assign secondary structure
dssp

# coloring by b-factor to show estimated modeling accuracy
color red, ss H
color gray80, ss L
color green, ss S
# spectrum b, blue_white_red

# labeling the β-strands
set label_size, -1.5

label 8/CA, u"\u03b21"
label 12/CA, u"\u03b22"
label 38/CA, u"\u03b23"
set label_color, magenta, 38/CA
label 42/CA, u"\u03b24"
label 49/CA, u"\u03b25"
set label_color, limegreen, 49/CA
label 58/CA, u"\u03b26"
label 71/CA, u"\u03b27"
set label_color, magenta, 71/CA
label 78/CA, u"\u03b28"
set label_color, limegreen, 78/CA
label 83/CA, u"\u03b29"
label 100/CA, u"\u03b210"
set label_color, magenta, 100/CA
label 105/CA, u"\u03b211"
set label_color, limegreen, 105/CA
label 112/CA, u"\u03b212"
label 125/CA, u"\u03b213"
set label_color, magenta, 125/CA
label 105/CA, u"\u03b211"
label 131/CA, u"\u03b214"
set label_color, limegreen, 131/CA
label 163/CA, u"\u03b215"
label 170/CA, u"\u03b216"
set label_color, magenta, 170/CA
label 182/CA, u"\u03b217"
set label_color, limegreen, 182/CA
label 190/CA, u"\u03b218"
label 208/CA, u"\u03b219"
set label_color, magenta, 208/CA
label 216/CA, u"\u03b220"
set label_color, limegreen, 216/CA
label 229/CA, u"\u03b221"
label 242/CA, u"\u03b222"
set label_color, magenta, 242/CA
label 250/CA, u"\u03b223"
set label_color, limegreen, 250/CA
label 259/CA, u"\u03b224"
label 268/CA, u"\u03b225"
label 271/CA, u"\u03b226"
set label_color, magenta, 271/CA
label 284/CA, u"\u03b227"
set label_color, limegreen, 284/CA
label 294/CA, u"\u03b228"
label 301/CA, u"\u03b229"
label 310/CA, u"\u03b230"
set label_color, limegreen, 310/CA

# set view
set_view (\
	-0.697869956,    0.322520554,   -0.639497042,\
	0.077692866,    0.921692848,    0.380057216,\
	0.711996257,    0.215547830,   -0.668282330,\
	0.000000000,    0.000000000, -164.778106689,\
	61.921691895,   61.908172607,   61.914581299,\
	66.238456726,  263.316131592,  -20.000000000 )
