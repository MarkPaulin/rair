#' Format R code
#'
#' Formats a string containing R code.
#' @param code character scalar containing R code
#' @param file path of R file to format
#'
#' @returns `format_code` returns the formatted R code. `format_file` returns
#'  a boolean that indicates if the file was changed
#'
#' @examples
#' bad_code <- "x+ 1  *(3 -0 )"
#' format_code(bad_code)
#'
#' tmp <- tempfile(fileext = ".R")
#' writeLines(tmp, bad_code)
#' format_file(tmp)
#' readLines(tmp
#'
#' @export
#' @rdname format
format_code <- function(code) {
  check_string(code, allow_empty = FALSE)
  .catch(format_code_(code))
}

#' @export
#' @rdname format
format_file <- function(file) {
  check_string(file, allow_empty = FALSE)
  .catch(format_file_(file))
}
