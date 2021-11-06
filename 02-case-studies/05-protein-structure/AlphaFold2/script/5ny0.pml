# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
fetch 5ny0
remove solvent

# coloring
color gray60
color yelloworange, ss H
color slate, ss S

# set view
set_view (\
		0.108765557,   -0.386890680,   -0.915688157,\
		0.873337090,    0.477179825,   -0.097881056,\
		0.474818468,   -0.789058626,    0.389786243,\
		0.000000000,    0.000000000, -184.557022095,\
		-2.424182892,   27.518213272,   50.467399597,\
		147.167907715,  221.946136475,  -20.000000000 )
### cut above here and paste into script ###

# export
ray 400, 600
png ../output/20211101-pdb-5ny0.png, dpi = 300
