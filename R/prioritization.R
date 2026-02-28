#' Prioritization index
#'
#' @description
#' Creates an index from each indicator (variable) in a data frame.
#'
#' @param x data frame with numeric or integer variables.
#' @param config data frame with standardization rules.
#'
#' @return
#' Data frame with standardized values and a prioritization index.
#'
#' @examples
#' # Example of how can be used this function.
#' data(male_spatial)
#' data(male_config)
#' prioritization(x = male_spatial, config = male_config)
#'
#' @export
prioritization <- function(x, config) {
  n_df <- x
  # if needed, drop the geometry
  if ("sf" %in% class(x)) {
    n_df <- sf::st_drop_geometry(n_df)
  }
  # Overwrite all columns with values from 0 to 100
  for (v in names(n_df)) {
    # Get parameters from config
    method <- list()
    method$id <- config[config$id == v, "method"]
    method$min <- config[config$id == v, "min"]
    method$max <- config[config$id == v, "max"]
    # Normalize n_df
    n_df[, v] <- s_standardize(
      x = n_df[, v],
      selected_method = method$id,
      min_bound = method$min,
      max_bound = method$max
    )
  }
  # Solve smaller better cases
  for (v in names(n_df)) {
    selected_direction <- config[which(config$id == v), "direction"]
    change_direction <- selected_direction == "smaller is better"
    n_df[, v] <- abs(n_df[, v] - as.numeric(change_direction) * 100)
  }
  # Prioritization Index calculation
  n_df$Index <- matrixStats::rowWeightedMeans(
    x = as.matrix(n_df),
    w = config$weight[which(config$id %in% names(n_df))]
  )

  # Return all outputs in a list

  if ("sf" %in% class(x)) {
    n_df <- sf::st_set_geometry(n_df, sf::st_geometry(x))
  }

  n_df
}
