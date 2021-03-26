
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nightvale

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mcguinlu/nightvale/workflows/R-CMD-check/badge.svg)](https://github.com/mcguinlu/nightvale/actions)
<!-- badges: end -->

## Background

[Welcome to Night Vale](http://www.welcometonightvale.com/) is a
twice-monthly podcast in the style of community updates for the small
desert town of Night Vale, with heavy themes of surreal humor and
horror. A key and recurring part of the show is “Today’s Proverb”. This
package provides the metadata and proverb for each episode as a dataset,
in addition to a function to return a nicely formatted proverb to the
console.

## Installation

This package is a GitHub only package, and can be installed using:

``` r
# install.packages("devtools")
devtools::install_github("mcguinlu/nightvale")
```

## Usage

### Access the data

``` r
library(nightvale)

head(proverb_data)
#>   id number                   title          airdate
#> 1  1      1                   Pilot     15 June 2012
#> 2  2      2              Glow Cloud      1 July 2012
#> 3  3      3      Station Management     15 July 2012
#> 4  4      4             PTA Meeting    1 August 2012
#> 5  5      5 The Shape in Grove Park   15 August 2012
#> 6  6      6          The Drawbridge 1 September 2012
#>                                                                                                                                        proverb
#> 1                                                                      Look to the north. Keep looking. There's nothing coming from the south.
#> 2                                                      Men are from Mars; women are from Venus; Earth is a hallucination; podcasts are dreams.
#> 3                                                                            There's a special place in Hell. It's really hip. Very exclusive.
#> 4 What has four legs in the morning, two legs at noon, and three legs in the evening? I don’t know, but I trapped it in my bedroom. Send help.
#> 5                                                                              A million dollars isn’t cool. You know what’s cool? A basilisk.
#> 6                                                                      Lost? Confused? Lacking direction? Need to find a purpose in your life?
```

### Get a random proverb

``` r
proverb()
#> "It's always darkest before the dawn," we are always reassured by people who are totally wrong about how the sun works.
#>     -- "Toast", 15 December 2016
```

### Get a specific proverb

``` r
proverb(22)
#> Ask your doctor if right is left for you.
#>     -- "A Memory of Europe", 15 April 2013
```
