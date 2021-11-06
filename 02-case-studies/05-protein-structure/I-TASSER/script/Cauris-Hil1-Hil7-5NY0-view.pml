# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/S614000_results/model1.pdb, Hil7
load ../data/S615682_results/model1.pdb, Hil1
fetch 5ny0
# remove water from the PDB structure
remove solvent

# hide the first 13 residues in Hil7 model as they don't belong to the PF11765 domain
hide cartoon, Hil7 AND i. 1-13

# align the center of mass for the two predicted models to the template and view them side-by-side
super Hil7, 5ny0
super Hil1, 5ny0
set grid_mode, 1
set grid_slot,1,Hil1
set grid_slot,2,5ny0
set grid_slot,3,Hil7

# load library
# import psico.editing

# use dssp to assign secondary structure
# dssp

# color the target sequence (Hil1) by secondary structure
spectrum count, blue_white_magenta, Hil1
spectrum count, blue_white_magenta, Hil7
spectrum count, blue_white_magenta, 5ny0
# change the beta-sheets to green
color limegreen, ss S

# set view: cross section
# scene cross, store 
#ray 2400, 1400
#png ../output/XP_028889361_1-327/20210609-side-by-side-align-to-Hil1-cross.png

# set view, longitudinal
set_view (\
		0.113594413,   -0.298465043,   -0.947636008,\
		0.884411216,    0.464953661,   -0.040425129,\
		0.452672958,   -0.833507419,    0.316781878,\
		-0.000000954,    0.000058617, -176.154861450,\
		-2.682565689,   26.397314072,   49.996143341,\
		138.881469727,  213.427337646,  -20.000000000 )
### cut above here and paste into script ###
scene long, store
#ray 2400, 1600
#png ../output/XP_028889361_1-327/20210609-side-by-side-align-to-Hil1-long.png

# color the loop by rainbow from N-to-C
#spectrum resi, rainbow, ss L
#ray 2400, 1600
#png ../output/XP_028889361_1-327/20210609-side-by-side-align-to-Hil1-long-rainbow.png
