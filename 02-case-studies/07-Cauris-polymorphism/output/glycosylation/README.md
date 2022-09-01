## Introduction & Approach
From [wikipedia](https://en.wikipedia.org/wiki/Glycosylation):

- N-linked glycans attached to a nitrogen of **asparagine** or arginine side-chains. N-linked glycosylation requires participation of a special lipid called dolichol phosphate.
- O-linked glycans attached to the hydroxyl oxygen of **serine, threonine, tyrosine**, hydroxylysine, or hydroxyproline side-chains, or to oxygens on lipids such as ceramide.

In adhesins, both types of glycosylations exist. In the Hil family, O-linked glycosylation on Ser/Thr residues appear to be the dominant type. Here we use two computational tools to predict both types in the B8441 Hil homologs.

- [NetNGlyc - v1.0](https://services.healthtech.dtu.dk/service.php?NetNGlyc-1.0)
- [NetOGlyc - v4.0](https://services.healthtech.dtu.dk/service.php?NetOGlyc-4.0)

## Output format:

### NetNGlyc
From tool website:

(Threshold=0.5)


|SeqName  |    Position | Sequon | Potential |  Jury agreement | NGlyc result | Comment |
|---------|---|---|---|--|---|--|
|CBG_HUMAN|     31 | NMSN |   0.7166  |   (9/9) |  ++ | Predicted as N-glycosylated (++) |
|CBG_HUMAN|     96 | NLTE |   0.6356  |   (8/9) |  +  | Predicted as N-glycosylated (+) |
|CBG_HUMAN|    176 | NKTQ |   0.3941  |   (7/9) |  -  | A negative site |
|CBG_HUMAN|    260 | NGTV |   0.7400  |   (9/9) |  ++ | Predicted as N-glycosylated (++) |
|CBG_HUMAN|    330 | NFSR |   0.4223  |   (7/9) |  -  | A negative site |
|CBG_HUMAN|    369 | NLTS |   0.6684  |   (9/9) |  ++ | Predicted as N-glycosylated (++) |

### NetOGlyc
> The output conforms to the GFF version 2 format. For each input sequence the server prints a list of potential glycosylation sites, showing their positions in the sequence and the prediction confidence scores. Only the sites with scores higher than 0.5 are predicted as glycosylated and marked with the string "#POSITIVE" in the comment field.
