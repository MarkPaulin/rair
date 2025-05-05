
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rair

<!-- badges: start -->

<!-- badges: end -->

This package is a wrapper around Posit’s Air R Formatter.

## Installation

You can install the development version of rair like so:

``` r
pak::pkg_install("markpaulin/rair")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(rair)
bad_code <- "x+ 1  *(3 -0 )"
format_code(bad_code)
#> [1] "x + 1 * (3 - 0)\n"
```
