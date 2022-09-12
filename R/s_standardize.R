#' Short title of the function given what it does
#'
#' @description
#' Short description of what the function does.
#'
#' @param x data frame of spatial polygons.
#' @param selected_method character vector.
#' @param MIN (default NULL).
#' @param MAX (default NULL).
#'
#' @return
#' Vector kind output by the function and short description if is necessary.
#'
#' @examples
#' # "benchmark" as selected method.
#' s_standardize(
#' x = c(0, 50, 100, 200),
#' selected_method = "benchmark",
#' MIN = 0,
#' MAX = 100)
#'
#' # "observe" as selected method
#' s_standardize(
#' x = c(-100, 50, 100, 200),
#' selected_method = "observe",
#' MIN = 0,
#' MAX = 100)
#'
#' @export
s_standardize <- function(x, selected_method = "observe", MIN = NULL, MAX = NULL ){
  # internal function: standardize a raster based on min and max values
  s_standardize_vector <- function(x, MIN, MAX){
    # let the smallest value be zero
    x <- x - MIN
    # let any number smaller than zero be zero
    x[x <= 0] <- 0
    # let the largest value be 100
    x <- 100*x/(MAX-MIN)
    # let any number larger than 100 be 100
    x[x >= 100] <- 100
    return(x)
  }
  # scale raster with different methods:
  # observe
  if(selected_method == "observe"){
    scaled_df <- s_standardize_vector(x = x, MIN = min(x), MAX = max(x))}
  # reference
  if(selected_method == "benchmark"){
    scaled_df <- s_standardize_vector(x = x, MIN = MIN, MAX = MAX)}
  # return a scaled df
  return(scaled_df)
}
