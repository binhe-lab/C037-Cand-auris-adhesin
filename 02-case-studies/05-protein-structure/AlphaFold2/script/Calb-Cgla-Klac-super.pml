# clean up the state
reinitialize

# start up settings
bg_color white
set valence, 0
set cartoon_side_chain_helper, on
set cartoon_discrete_color, 1
set seq_view, 1

# load pdb
load ../data/Calbicans-Hyr1-full/AF-Q5AL03-F1-model_v1.pdb, Calbfull
load ../data/Cglabrata-XP_447567.2-PF11765/selected_prediction.pdb, Cgla
load ../data/Klactis-XP_447567.2-PF11765/selected_prediction.pdb, Klac

# only show the PF11765 domain portion of Calbfull
select Calb, Calbfull and resi 11-334
hide everything, Calbfull
show cartoon, Calb

# align objects
align Cgla, Calb
align Klac, Calb

# view side by side
set grid_mode, 1
set grid_slot, 1, Calb
set grid_slot, 2, Cgla
set grid_slot, 3, Klac

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
		0.633003891,    0.690497875,    0.350028723,\
		-0.483975172,    0.000080087,    0.875078797,\
		0.604212463,   -0.723336518,    0.334234804,\
		0.000000000,    0.000000000, -312.320587158,\
		-1.142829895,    0.461673737,   -1.043529510,\
		262.990509033,  361.650726318,  -20.000000000 )
### cut above here and paste into script ###

scene long, store
ray 2200, 1200
png ../output/20211121-AF2-Calb-Cgla-Klac-super.png, dpi=300

### cut below here and paste into script ###
set_view (\
		0.578260303,   -0.366043001,    0.729127169,\
		-0.584013522,   -0.809761882,    0.056652442,\
		0.569682121,   -0.458581150,   -0.682031870,\
		0.000000000,    0.000000000, -312.320587158,\
		-1.142829895,    0.461673737,   -1.043529510,\
		262.990509033,  361.650726318,  -20.000000000 )
### cut above here and paste into script ###
scene cross, store
ray 1600, 400
png ../output/20211121-AF2-Calb-Cgla-Klac-super-cross.png, dpi=300

