
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

- **Modern infrastructure** – foregoes the use of S4 OOP to provide a
  simple, transparent data structure.
- **Functional and flexible** – `flowplyr` makes flow data accessible,
  so you can `purrr`, `dplyr`, `data.table`, or base R as you would any
  type of data.  
- **Interoperable design** – easily integrate your flow data analysis
  with your normal choice of downstream tools for visualization,
  modeling, saving, and reporting.
- **Unified data representation** – handles all fcs-file slots
  (i.e. *expression data* and *metadata*)

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

*TBD*
