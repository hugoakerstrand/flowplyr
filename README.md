
<!-- README.md is generated from README.Rmd. Please edit that file -->

# flowplyr

<!-- badges: start -->

<!-- badges: end -->

## A modern and flexible framework for flow cytometry data in R

`flowplyr` is a reimagined foundation for working with flow cytometry
data in R — designed for modern data science workflows.

It aims to make flow cytometry data accessible, composable, and fully
compatible with the **tidyverse**, **functional programming**, and other
R ecosystems, without forcing any particular paradigm.

## ✨ Key goals

- **Modern infrastructure** – a clean alternative to `flowCore` built on
  simple, transparent data structures.  
- **Functional and flexible** – `flowplyr` makes flow data accessible,
  so you can `purrr`, `dplyr`, `data.table`, or base R as you would any
  type of data.  
- **Interoperable design** – easily integrate your flow data analysis
  with your normal choice of downstream tools for visualization,
  modeling, saving, and reporting.
- **Unified data representation** – handles all fcs-file slots
  (i.e. *expression data* and *metadata*)

------------------------------------------------------------------------

## 📦 Installation

*NB! `flowplyr` is under heavy development and subject to sweeping,
rolling changes*

You can install the development version of `flowplyr` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("hugoakerstrand/flowplyr")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(flowplyr)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
