
# cdphmd

<!-- badges: start -->
[![R build status](https://github.com/ikbentimkramer/cdphmd/workflows/R-CMD-check/badge.svg)](https://github.com/ikbentimkramer/cdphmd/actions)
[![codecov](https://codecov.io/gh/ikbentimkramer/cdphmd/branch/master/graph/badge.svg?token=I9K0S5EY54)](https://codecov.io/gh/ikbentimkramer/cdphmd)
<!-- badges: end -->

The cdphmd (Collaborative Data Project Housing Market Dashboard) is a dashboard for the housing market in the north of the Netherlands.

## Installation
To install the cdp.housingDashboard, you need to install the package devtools in R:

``` r
install.packages("devtools")
```

This enables you to run the following:

``` r
devtools::install_github("ikbentimkramer/cdphmd")
```

which installs cdphmd

## Usage

When you have cdphmd installed, run:

``` r
cdphmd::run()
```

to start the dashboard.
