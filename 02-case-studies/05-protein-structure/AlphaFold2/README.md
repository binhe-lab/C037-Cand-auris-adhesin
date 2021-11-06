# AlphaFold2 predictions
## Goal
Predict the structure for the PF11765 domain in _C. auris_ Hil proteins

## Algorithm
Used the [Google Colab IPython Notebook](https://colab.research.google.com/github/deepmind/alphafold/blob/main/notebooks/AlphaFold.ipynb), which implements a simplified version of [AlphaFold2](https://github.com/deepmind/alphafold) with potentially reduced accuracy (because it doesn't use a template and searches a selected portion of the BFD database (see the notebook above for details).

## Method
- Open the Google Colab notebook, run the first two code cells to install the necessary tools
- Obtain the protein sequences for the target domain, e.g. 12-327 aa for _C. auris_ Hil1 and insert it into the 3rd cell and run it.
- Run the 3rd and 4th cells to perform the search and prediction.
- Save the result as a zip file in the [data](./data) folder.
