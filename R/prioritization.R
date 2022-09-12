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
prioritization <- function(x, config){
  N <- x
  # if needed, drop the geometry
  if("sf" %in% class(x)){N <- sf::st_drop_geometry(N)}
  # Overwrite all columns with values from 0 to 100
  for(v in names(N)){
    # Get parameters from config
    method <- list()
    method$id <- config[config$id == v, "method"]
    method$min <- config[config$id == v, "min"]
    method$max <- config[config$id == v, "max"]
    # Normalize N
    N[,v] <- s_standardize(x = N[,v],
                           selected_method = method$id,
                           MIN = method$min,
                           MAX = method$max)
  }
  # Solve smaller better cases
  for(v in names(N)){
    selected_direction <- config[which(config$id == v), "direction"]
    change_direction <- selected_direction == "smaller is better"
    N[,v] <- abs(N[,v] - as.numeric(change_direction) * 100)
  }
  # Prioritization Index calculation
  N$Index <- matrixStats::rowWeightedMeans(x = as.matrix(N),
                              w = config$weight[which(config$id %in% names(N))])

  # Return all outputs in a list

  if("sf" %in% class(x)){N <- sf::st_set_geometry(N, sf::st_geometry(x))}
  
  return(N)

}
