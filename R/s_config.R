#' s_config
#'
#' @description
#' Creates an config data frame from a data frame or sf.
#'
#' @param x a data frame.
#' @param name human friendly names for each variable in x. Defaults to column names in x.
#' @param group vector with the grouping variable  with the same length as rows in x. Defaults to a single "general" group.
#' @param weight vector with the weights that that will be passed to weighted mean. The vector might have a single character, or a vector with the same length as rows in x. Defaults to 1.
#' @param direction vector stating if each variable in x "larger is better" or "smaller is better". The vector might have a single character, or a character vector with the same length as rows in x. Defaults to "smaller is better".
#' @param method vector stating the standardization method should be observe or benchmark. The vector might have a single character or a character vector with the same length as rows in x. Defaults to "observe".
#' @param min vector with the minimum value that should be considered in the benchmark method. The vector might have a single number or a numeric vector with the same length as rows in x. Defaults to the min value for each variable in x.
#' @param max vector with the maximum value that should be considered in the benchmark method. The vector might have a single number or a numeric vector with the same length as rows in x. Defaults to the max value for each variable in x.
#'
#' @return
#' A config data frame.
#' 
#' @examples
#' data(male)
#' x <- sf::st_drop_geometry(male_spatial)
#' s_config(x)
#'
#' @export
s_config <- function(x, name = NA, group = NA, weight = NA,
                     direction = NA,  method =  NA,  min = NA,  max =  NA){
  # Create an id for each variable in the data frame
  id = names(x)
  # If the name was not provided, use the id as the name
  if(all(is.na(name))){name = id}
  # If the group is not provided, use "general" as the group name
  if(all(is.na(group))){group = "general"}
  # If the group was not provided, use 1 (all layers have equal weights)
  if(all(is.na(weight))){weight = 1}
  # If the direction was not provided, assume that smaller is better
  if(all(is.na(direction))){direction = "smaller is better"}
  # If the method was not provided, assume that the method is "observe"
  if(all(is.na(method))){method = "observe"}
  # If the min and max values were not provided, calculate them.
  if(all(is.na(min))){min = matrixStats::colMins(as.matrix(x))}
  if(all(is.na(max))){max = matrixStats::colMaxs(as.matrix(x))}

  # Prepare and return a data frame with the config format
  return(
    data.frame(
      id = id,
      name = name,
      weight = weight,
      direction = direction,
      method = method,
      min = min,
      max = max
    )
  )
}
