# ttgenome
 genome analysis and visulization tools

## install

``` r
# install.package("remotes")   #In case you have not installed it.
remotes::install_github("TongZhou2017/ttgenome")
```

## load package

```r
library(ttgenome)
```

## Read data

``` r
divsum <- set_divsum(file = system.file("extdata","Adig.genome.fasta.divsum",package = "ttgenome"),
                    species = "Adig",
                    genome_size = 415842489)
```

## Visulization

``` r
p3(divsum)
```
![p1](docs/Rplot.png)

``` r
p3(divsum,keep_unknown = FALSE)
```
![p2](docs/Rplot01.png)

``` r
p3(divsum,sublabel = "6",keep_unknown = FALSE)
```
![p3](docs/plot_zoom_6.png)

``` r
p3(divsum,sublabel = "All",keep_unknown = FALSE)
```
![p4](docs/plot_zoom.png)
