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
prioritization <- function(x, config, na.rm = TRUE) {
  # 1. Validation
  if (!all(names(x) %in% config$id)) {
    warning("Some columns in x are not defined in config and will be ignored.")
  }
  
  # 2. Separate Geometry if SF
  is_sf <- inherits(x, "sf")
  if (is_sf) {
    geom <- sf::st_geometry(x)
    x_data <- sf::st_drop_geometry(x)
  } else {
    x_data <- x
  }
  
  # 3. Standardization (Vectorized)
  # Iterate only over columns present in config
  valid_cols <- intersect(names(x_data), config$id)
  
  for (v in valid_cols) {
    rule <- config[config$id == v, ]
    
    # Normalize
    val <- s_standardize(x_data[[v]], 
                         selected_method = rule$method, 
                         MIN = rule$min, 
                         MAX = rule$max)
    
    # Invert if "smaller is better"
    if (rule$direction == "smaller is better") {
      val <- 100 - val
    }
    x_data[[v]] <- val
  }
  
  # 4. Aggregation
  # Match weights to the current column order
  weights <- config$weight[match(valid_cols, config$id)]
  
  x_data$Index <- matrixStats::rowWeightedMeans(
    as.matrix(x_data[valid_cols]), 
    w = weights, 
    na.rm = na.rm
  )
  
  # 5. Reconstruct
  if (is_sf) {
    x_data <- sf::st_set_geometry(x_data, geom)
  }
  
  return(x_data)
}