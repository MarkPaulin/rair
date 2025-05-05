
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rair

<!-- badges: start -->

[![R-CMD-check](https://github.com/MarkPaulin/rair/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/MarkPaulin/rair/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/MarkPaulin/rair/graph/badge.svg)](https://app.codecov.io/gh/MarkPaulin/rair)
<!-- badges: end -->

This package is a wrapper around Posit’s Air R Formatter.

## Installation

You can install the development version of rair like so:

``` r
pak::pkg_install("markpaulin/rair")
```

## Example

`rair` can be used to format R code:

``` r
library(rair)
bad_code <- "x+ 1  *(3 -0 )"
cat(format_code(bad_code))
#> x + 1 * (3 - 0)
```

## Acknowledgements

This project is a thin wrapper around the
[Air](https://github.com/posit-dev/air) formatter. It is heavily
dependent on the [rextendr](https://github.com/extendr/rextendr)
package, and draws from the
[tomledit](https://github.com/extendr/tomledit) package for rust-related
inspiration and from [styler](https://github.com/r-lib/styler) for
designing an R API for styling code.
