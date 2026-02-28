# Prioritization index

Creates an index from each indicator (variable) in a data frame.

## Usage

``` r
prioritization(x, config)
```

## Arguments

- x:

  data frame with numeric or integer variables.

- config:

  data frame with standardization rules.

## Value

Data frame with standardized values and a prioritization index.

## Examples

``` r
# Example of how can be used this function.
data(male_spatial)
data(male_config)
prioritization(x = male_spatial, config = male_config)
#> Simple feature collection with 395 features and 8 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 73.50077 ymin: 4.168565 xmax: 73.51906 ymax: 4.181027
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>   schools hospitals clinics cultural government transit financial    Index
#> 0       0         0       0        0          0     100         0 16.66667
#> 1       0         0       0        0          0     100         0 16.66667
#> 2       0         0       0        0          0     100         0 16.66667
#> 3       0         0       0        0          0     100         0 16.66667
#> 4       0         0       0        0          0       0         0  0.00000
#> 5       0         0       0        0          0       0         0  0.00000
#> 6       0         0       0        0          0       0         0  0.00000
#> 7       0         0       0        0          0       0         0  0.00000
#> 8       0         0       0        0          0       0         0  0.00000
#> 9       0         0       0        0          0       0         0  0.00000
#>                         geometry
#> 0 MULTIPOLYGON (((73.50222 4....
#> 1 MULTIPOLYGON (((73.50433 4....
#> 2 MULTIPOLYGON (((73.5064 4.1...
#> 3 MULTIPOLYGON (((73.5097 4.1...
#> 4 MULTIPOLYGON (((73.5156 4.1...
#> 5 MULTIPOLYGON (((73.51776 4....
#> 6 MULTIPOLYGON (((73.50293 4....
#> 7 MULTIPOLYGON (((73.50124 4....
#> 8 MULTIPOLYGON (((73.50143 4....
#> 9 MULTIPOLYGON (((73.50274 4....
```
