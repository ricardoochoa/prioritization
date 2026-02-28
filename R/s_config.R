#' Create a config data frame
#'
#' @description
#' Creates a standardized configuration data frame from a provided data frame
#' or \code{sf} object. The config table is intended for multi-criteria
#' evaluation workflows.
#'
#' @param x A \code{data.frame} or \code{sf} object. If \code{sf}, geometry
#'   might need to be dropped first depending on the workflow.
#' @param name Human-friendly names for each variable in \code{x}.
#'   Defaults to column names in \code{x}.
#' @param group A character vector with the grouping variable for each column
#'   in \code{x}. Defaults to a single "general" group.
#' @param weight A numeric vector with the weights that will be passed to the
#'   weighted mean. The vector might be a single number or a vector with the
#'   same length as the number of columns in \code{x}. Defaults to 1.
#' @param direction A character vector stating if each variable in \code{x}
#'   considers "larger is better" or "smaller is better".
#'   Defaults to "smaller is better".
#' @param method A character vector stating if the standardization method
#'   should be "observe" or "benchmark". Defaults to "observe".
#' @param min A numeric vector representing the minimum value that should be
#'   considered in the "benchmark" method. Defaults to the calculated minimum
#'   value for each column in \code{x}.
#' @param max A numeric vector representing the maximum value that should be
#'   considered in the "benchmark" method. Defaults to the calculated maximum
#'   value for each column in \code{x}.
#'
#' @return
#' A \code{data.frame} where each row represents the configuration for a
#' single variable (column) in \code{x}. The data frame contains the following
#' columns: \code{id}, \code{name}, \code{weight}, \code{direction},
#' \code{method}, \code{min}, and \code{max}.
#'
#' @examples
#' # Use a sample data frame to create the config table
#' sample_data <- data.frame(
#'   population = c(100, 200, 300),
#'   cost = c(500, 100, 250)
#' )
#'
#' # Create a default config
#' s_config(sample_data)
#'
#' # Create a custom config indicating 'cost' is smaller is better
#' s_config(
#'   sample_data,
#'   direction = c("larger is better", "smaller is better")
#' )
#'
#' @importFrom matrixStats colMins colMaxs
#' @export
s_config <- function(x, name = NA, group = NA, weight = NA,
                     direction = NA, method = NA, min = NA, max = NA) {
  # Ensure input is a data frame or matrix before analyzing columns
  if (!is.data.frame(x) && !is.matrix(x)) {
    stop("Input 'x' must be a data frame or a matrix.")
  }

  # Create an id for each variable in the data frame
  id <- names(x)

  # If the name was not provided, use the id as the name
  if (all(is.na(name))) {
    name <- id
  }

  # If the group is not provided, use "general" as the group name
  if (all(is.na(group))) {
    group <- "general"
  }

  # If the weight was not provided, use 1 (all layers have equal weights)
  if (all(is.na(weight))) {
    weight <- 1
  }

  # If the direction was not provided, assume that smaller is better
  if (all(is.na(direction))) {
    direction <- "smaller is better"
  }

  # If the method was not provided, assume that the method is "observe"
  if (all(is.na(method))) {
    method <- "observe"
  }

  # If the min and max values were not provided, calculate them.
  if (all(is.na(min))) {
    min <- matrixStats::colMins(as.matrix(x), na.rm = TRUE)
  }
  if (all(is.na(max))) {
    max <- matrixStats::colMaxs(as.matrix(x), na.rm = TRUE)
  }

  # Prepare and return a data frame with the config format
  config_df <- data.frame(
    id = id,
    name = name,
    group = group,
    weight = weight,
    direction = direction,
    method = method,
    min = min,
    max = max
  )

  config_df
}
