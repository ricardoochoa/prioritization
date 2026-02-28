# Introduction to prioritization

The `prioritization` package provides spatial and non-spatial tools to
assist with spatial planning and investment prioritization workflows.

In this vignette, we will walk through the two core multi-criteria
evaluation functions currently in the package: configuring your
constraints (`s_config`) and standardizing your inputs
(`s_standardize`).

## Setup

First, load the package:

``` r
library(prioritization)
```

## Standardizing Data

Continuous values often need to be standardized to a 0-100 scale before
they can be weighted and combined. We can do this using
[`s_standardize()`](../reference/s_standardize.md).

The function supports two scaling methods: `"observe"` (scaling purely
based on the local minimum and maximum of the dataset) and `"benchmark"`
(scaling based on absolute reference values that you provide).

``` r
# A simple vector of costs
costs <- c(150, 200, 350, 500)

# Observe method (relative scaling)
s_standardize(costs, selected_method = "observe")
#> [1]   0.00000  14.28571  57.14286 100.00000

# Benchmark method (absolute scaling against limits of 0 and 1000)
s_standardize(costs, selected_method = "benchmark", 
              min_bound = 0, max_bound =1000)
#> [1] 15 20 35 50
```

## Configuring Parameters for Prioritization

Before assembling a spatial score, you need a configuration `data.frame`
mapping variable behaviors (direction, weights, standardization bounds).
You can generate this mapping directly from your raw dataset using
[`s_config()`](../reference/s_config.md).

``` r
# Suppose we have dataset with population and infrastructure cost
planning_data <- data.frame(
  pop_density = c(10, 50, 100, 20),
  cost = c(500, 1500, 800, 1000)
)

# Tell the config that higher population is better, but lower cost is better
my_config <- s_config(
  planning_data,
  direction = c("larger is better", "smaller is better")
)

my_config
#>                      id        name   group weight         direction  method
#> pop_density pop_density pop_density general      1  larger is better observe
#> cost               cost        cost general      1 smaller is better observe
#>             min  max
#> pop_density  10  100
#> cost        500 1500
```

The resulting configuration table can then be used in downstream spatial
prioritization scripts to ensure all spatial layers are standardized and
aggregated correctly.
