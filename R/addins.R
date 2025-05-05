format_active_file <- function() {
  ctx <- rstudioapi::getActiveDocumentContext()
  out <- format_code(paste0(ctx$contents, collapse = "\n"))

  rstudioapi::setDocumentContents(
    out,
    id = ctx$id
  )

  rstudioapi::setCursorPosition(ctx$selection[[1L]]$range)
}
