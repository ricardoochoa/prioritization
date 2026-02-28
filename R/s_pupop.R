#' Pop ups
#'
#' @description
#' Create a character vector that summarizes and formats all variables
#' in a data frame.
#'
#' @param x parameter name and vector type.
#' @param r parameter name and vector type.
#' @param my_variables parameter name and vector type.
#' @param pretty_names parameter name and vector type.
#' @param digits (default 0).
#'
#' @return
#' Vector kind output by the function and short description if is necessary.
#'
#' @examples
#' # Example of how can be used this function.
#' # Code lines
#'
#' @export
s_popup <- function(x, r, my_variables, pretty_names, digits = 0) {
  # select row r from x dataframe
  x <- x[r, c(my_variables)]
  # round those variables which are numeric
  for (v in seq_along(my_variables)) {
    if (is.numeric(x[, v])) {
      x[, v] <- round(x = x[, v], digits = digits)
    } else {}
  }
  # transpose
  x <- data.frame(t(x))
  # use pretty names
  row.names(x) <- pretty_names
  # create html popup
  x <- paste0("<b> ", row.names(x), ": </b>", x[, 1])
  paste0(x, collapse = "<br/>")
}
