---
title:  commands I figured out how to use in PyMol
author: Bin He
date:   2021-06-09
---

# side by side view
set grid_mode, 1

# set color by secondary structure for a particular object
#   the key here is to understand the selection algebra: https://pymolwiki.org/index.php/Selection_Algebra
color red, model1 AND ss H
#   the above means set the color to red for helices and only in model1
