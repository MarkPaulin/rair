#' Format R code
#'
#' Formats a string containing R code.
#' @param code character scalar containing R code
#' @param file path of R file to format
#' @param line_width preferred maximum line length
#' @param indent_width number of spaces per indentation level
#' @param indent_style whether to use `"spaces"` or `"tabs"` for indentation
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
format_code <- function(code, line_width = NULL, indent_width = NULL, indent_style = NULL) {
  check_string(code, allow_empty = FALSE)
  check_number_whole(line_width, allow_null = TRUE)
  stopifnot("`indent_width` must be positive" = line_width > 0)

  check_number_whole(indent_width, allow_null = TRUE)
  stopifnot("`line_width` must be positive" = line_width > 0)

  check_string(indent_style, allow_null = TRUE)
  stopifnot("`indent_style` must be one of 'tab' or 'space'" = indent_style %in% c("tab", "space"))

  options <- list(line_width = line_width, indent_width = indent_width, indent_style = indent_style)
  .catch(format_code_(code, options))
}

#' @export
#' @rdname format
format_file <- function(file, line_width = NULL, indent_width = NULL, indent_style = NULL) {
  check_string(file, allow_empty = FALSE)
  check_number_whole(line_width, allow_null = TRUE)
  stopifnot("`indent_width` must be positive" = line_width > 0)

  check_number_whole(indent_width, allow_null = TRUE)
  stopifnot("`line_width` must be positive" = line_width > 0)

  check_string(indent_style, allow_null = TRUE)
  stopifnot("`indent_style` must be one of 'tab' or 'space'" = indent_style %in% c("tab", "space"))

  options <- list(line_width = line_width, indent_width = indent_width, indent_style = indent_style)

  .catch(format_file_(file, options))
}
