#' Standardize a vector of numeric values
#'
#' @description
#' Standardizes a numeric vector using either an "observe" method (scaling based on the vector's empirical min and max) or a "benchmark" method (scaling based on user-supplied reference min and max bounds). Values are scaled to a 0 to 100 range.
#'
#' @param x A numeric vector to standardize.
#' @param selected_method A character string indicating the scaling method. Must be either \code{"observe"} (default) or \code{"benchmark"}.
#' @param MIN A numeric value representing the minimum reference bound. Required if \code{selected_method} is \code{"benchmark"}. Default is \code{NULL}.
#' @param MAX A numeric value representing the maximum reference bound. Required if \code{selected_method} is \code{"benchmark"}. Default is \code{NULL}.
#'
#' @return
#' A numeric vector of the same length as \code{x}, where the values have been scaled to lie between 0 and 100.
#'
#' @examples
#' # "benchmark" as selected method
#' s_standardize(
#'   x = c(0, 50, 100, 200),
#'   selected_method = "benchmark",
#'   MIN = 0,
#'   MAX = 100
#' )
#'
#' # "observe" as selected method
#' s_standardize(
#'   x = c(-100, 50, 100, 200),
#'   selected_method = "observe"
#' )
#'
#' @export
s_standardize <- function(x, selected_method = "observe", MIN = NULL, MAX = NULL) {
  
  # Validate input method
  if (!selected_method %in% c("observe", "benchmark")) {
    stop("`selected_method` must be either 'observe' or 'benchmark'.")
  }
  
  # Defensive check for benchmark requires MIN and MAX
  if (selected_method == "benchmark") {
    if (is.null(MIN) || is.null(MAX)) {
      stop("`MIN` and `MAX` parameters must be provided when `selected_method` is 'benchmark'.")
    }
  }

  # Internal function: standardize a vector based on min and max values
  s_standardize_vector <- function(v, min_val, max_val) {
    if (max_val == min_val) {
      warning("MIN and MAX are equal; returning a vector of zeros.")
      return(rep(0, length(v)))
    }
    # let the smallest value be zero
    v <- v - min_val
    # let any number smaller than zero be zero
    v[v <= 0] <- 0
    # let the largest value be 100
    v <- 100 * v / (max_val - min_val)
    # let any number larger than 100 be 100
    v[v >= 100] <- 100
    
    return(v)
  }

  # scale vector with different methods:
  if (selected_method == "observe") {
    scaled_vec <- s_standardize_vector(v = x, min_val = min(x, na.rm = TRUE), max_val = max(x, na.rm = TRUE))
  } else if (selected_method == "benchmark") {
    scaled_vec <- s_standardize_vector(v = x, min_val = MIN, max_val = MAX)
  }
  
  return(scaled_vec)
}
