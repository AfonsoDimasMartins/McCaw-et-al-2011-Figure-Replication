# McCaw et al (2011) Figure Replication

Version 0.1.0

McCaw et al Figure Replication


## Project objective

- What does this project do?
In this code we intend on replicating the results of McCaw et al (2011). The study can be found here: https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002026
In a nutshell, the authors inoculated donor ferrets with two influenza strains, a mutant and a wild-type strain, and measured their relative proportions after transmission to recipient ferrets. The data consists of 9 data points that represent these two strains at different proportions in the donor and recipient ferrets. We replicate their proposed model to fit the data and reproduce the figures 1, 2 and 4A of the study. 

- What do the functions do?
The function model_curve is used to plot a curve given a certain value for s, a parameter in the authors model. The input should be always one number.
The function model_mse is used to calculate the mean squared errors between a proposed curve and the data. The input should be a vector of length 9 to match the data structure.
The R function optim is used to minimize the mean squared errors so we arrive at the best curve to fit the data, given these model assumptions.
The remaining code is scripted elements to plot our replication of figures 1, 2 and 4A.

- How does the user access your project?
The code is self suficient and does not have any dependencies. The user just needs to run the code. 



## Project organization

```
.
├── .gitignore
├── CITATION.md
├── LICENSE.md
├── README.md
├── requirements.txt
├── bin                <- Compiled and external code, ignored by git (PG)
│   └── external       <- Any external source code, ignored by git (RO)
├── config             <- Configuration files (HW)
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for modeling. (PG)
│   ├── raw            <- The original, immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── src                <- Source code for this project (HW)

```


## License

This project is licensed under the terms of the [MIT License](/LICENSE.md)

## Citation

Please [cite this project as described here](/CITATION.md).
