# physplit.analysis
[![Docs](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](http://jefferislab.github.io/physplit.analysis/reference/)

R analysis functions for Shahar Frechter's in vivo patch clamp recordings
of olfactory neurons as described in 

Functional and anatomical specificity in a higher olfactory centre
Shahar Frechter, Alexander Shakeel Bates, Sina Tootoonian, Michael-John Dolan,
James Manton, Arian Rokkum Jamasb, Johannes Kohl, Davi Bock, Gregory Jefferis
https://doi.org/10.7554/eLife.44590

# Install

```r
# install remotes package if required
if (!requireNamespace("remotes")) install.packages("remotes")

# then install
remotes::install_github("jefferislab/physplit.analysis")
```

## Hacking physplit.analysis
You can clone this repo and use RStudio to work with `physplitdata.Rproj` to 
work on the functions in this package.

You can also install from a local checkout if you happen to have one – something 
like this.

```r
devtools::install_git("~/dev/R/physplitdata")
```
