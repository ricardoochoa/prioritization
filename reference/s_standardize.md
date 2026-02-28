# Standardize a vector of numeric values

Standardizes a numeric vector using either an "observe" method (scaling
based on the vector's empirical min and max) or a "benchmark" method
(scaling based on user-supplied reference min and max bounds). Values
are scaled to a 0 to 100 range.

## Usage

``` r
s_standardize(
  x,
  selected_method = "observe",
  min_bound = NULL,
  max_bound = NULL
)
```

## Arguments

- x:

  A numeric vector to standardize.

- selected_method:

  A character string indicating the scaling method. Must be either
  `"observe"` (default) or `"benchmark"`.

- min_bound:

  A numeric value representing the minimum reference bound. Required if
  `selected_method` is `"benchmark"`. Default is `NULL`.

- max_bound:

  A numeric value representing the maximum reference bound. Required if
  `selected_method` is `"benchmark"`. Default is `NULL`.

## Value

A numeric vector of the same length as `x`, where the values have been
scaled to lie between 0 and 100.

## Examples

``` r
# "benchmark" as selected method
s_standardize(
  x = c(0, 50, 100, 200),
  selected_method = "benchmark",
  min_bound = 0,
  max_bound = 100
)
#> [1]   0  50 100 100

# "observe" as selected method
s_standardize(
  x = c(-100, 50, 100, 200),
  selected_method = "observe"
)
#> [1]   0.00000  50.00000  66.66667 100.00000
```
