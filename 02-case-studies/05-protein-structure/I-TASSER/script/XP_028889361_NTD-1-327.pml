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

# hide the first 13 residues in Hil7 model as they don't belong to the PF11765 domain
hide cartoon, Hil7 AND i. 1-13

# align the two objects and view them side-by-side
align Hil7, Hil1
set grid_mode, 1

# load library
import psico.editing

# use dssp to assign secondary structure
dssp

# color the target sequence (Hil1) by secondary structure
color red, Hil1 AND ss H
color gray80, Hil1 AND ss L
color limegreen, Hil1 AND ss S
set cartoon_transparency, 0.1, Hil1

# color the query sequenc by secondary structure
color hotpink, Hil7 AND ss H
color gray90, Hil7 AND ss L
color green, Hil7 AND ss S

# labeling the β-strands
set label_size, -1.5

# set view, longitudinal
set_view (\
	-0.697869956,    0.322520554,   -0.639497042,\
	0.077692866,    0.921692848,    0.380057216,\
	0.711996257,    0.215547830,   -0.668282330,\
	0.000000000,    0.000000000, -164.778106689,\
	61.921691895,   61.908172607,   61.914581299,\
	66.238456726,  263.316131592,  -20.000000000 )

ray 1200, 800
png ../output/XP_028889361_1-327/20210609-side-by-side-align-to-Hil1.png

# set view: cross section
set_view (\
		0.238507941,   -0.954743385,   -0.177700624,\
		-0.285257429,    0.106033862,   -0.952565074,\
		0.928302348,    0.277883291,   -0.247060001,\
		0.000000000,    0.000000000, -164.778106689,\
		61.921691895,   61.908172607,   61.914581299,\
		66.238456726,  263.316131592,  -20.000000000 )
ray 1200, 700
png ../output/XP_028889361_1-327/20210609-side-by-side-align-to-Hil1-cross.png
