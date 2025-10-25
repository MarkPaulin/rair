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
#' @export
#' @rdname format
format_code <- function(code, line_width = NULL) {
  check_string(code, allow_empty = FALSE)
  check_number_whole(line_width, allow_null = TRUE)
  stopifnot("`line_width` must be positive" = line_width > 0)

  options <- list(line_width = line_width)
  .catch(format_code_(code, options))
}

#' @export
#' @rdname format
format_file <- function(file, line_width = NULL) {
  check_string(file, allow_empty = FALSE)
  check_number_whole(line_width, allow_null = TRUE)
  stopifnot("`line_width` must be positive" = line_width > 0)

  options <- list(line_width = line_width)

  .catch(format_file_(file, options))
}
