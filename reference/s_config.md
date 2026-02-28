# Create a config data frame

Creates a standardized configuration data frame from a provided data
frame or `sf` object. The config table is intended for multi-criteria
evaluation workflows.

## Usage

``` r
s_config(
  x,
  name = NA,
  group = NA,
  weight = NA,
  direction = NA,
  method = NA,
  min = NA,
  max = NA
)
```

## Arguments

- x:

  A `data.frame` or `sf` object. If `sf`, geometry might need to be
  dropped first depending on the workflow.

- name:

  Human-friendly names for each variable in `x`. Defaults to column
  names in `x`.

- group:

  A character vector with the grouping variable for each column in `x`.
  Defaults to a single "general" group.

- weight:

  A numeric vector with the weights that will be passed to the weighted
  mean. The vector might be a single number or a vector with the same
  length as the number of columns in `x`. Defaults to 1.

- direction:

  A character vector stating if each variable in `x` considers "larger
  is better" or "smaller is better". Defaults to "smaller is better".

- method:

  A character vector stating if the standardization method should be
  "observe" or "benchmark". Defaults to "observe".

- min:

  A numeric vector representing the minimum value that should be
  considered in the "benchmark" method. Defaults to the calculated
  minimum value for each column in `x`.

- max:

  A numeric vector representing the maximum value that should be
  considered in the "benchmark" method. Defaults to the calculated
  maximum value for each column in `x`.

## Value

A `data.frame` where each row represents the configuration for a single
variable (column) in `x`. The data frame contains the following columns:
`id`, `name`, `weight`, `direction`, `method`, `min`, and `max`.

## Examples

``` r
# Use a sample data frame to create the config table
sample_data <- data.frame(
  population = c(100, 200, 300),
  cost = c(500, 100, 250)
)

# Create a default config
s_config(sample_data)
#>                    id       name   group weight         direction  method min
#> population population population general      1 smaller is better observe 100
#> cost             cost       cost general      1 smaller is better observe 100
#>            max
#> population 300
#> cost       500

# Create a custom config indicating 'cost' is smaller is better
s_config(
  sample_data,
  direction = c("larger is better", "smaller is better")
)
#>                    id       name   group weight         direction  method min
#> population population population general      1  larger is better observe 100
#> cost             cost       cost general      1 smaller is better observe 100
#>            max
#> population 300
#> cost       500
```
