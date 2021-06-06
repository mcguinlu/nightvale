
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nightvale

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![GitHub
Actions](https://github.com/mcguinlu/nightvale/actions/workflows/scrape_data.yml/badge.svg)](https://github.com/mcguinlu/nightvale/actions)
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
#> We are living in an immaterial world, a ghost world, and I am an immaterial girl - a ghost.
#>     -- "The Lights in Radon Canyon", 1 October 2012
```

### Get a specific proverb

``` r
proverb(22)
#> Ask your doctor if right is left for you.
#>     -- "A Memory of Europe", 15 April 2013
```

## Git Scraping

The Welcome to Night Vale podcast continues to release a new show every
two weeks. In order to capture the proverbs from these new episodes,
this project also contains a GitHub Action that automatically re-scrapes
the [community-maintained table of
proverbs](https://nightvale.fandom.com/wiki/List_of_Proverbs) every
week. When new proverbs are identified, the proverb dataset included as
part of this package is updated.

To get the most up-to-date version of the proverb dataset, simply
re-install the package using:

``` r
devtools::install_github("mcguinlu/nightvale")
```
