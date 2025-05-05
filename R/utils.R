# copied from https://github.com/extendr/tomledit/blob/378e1a2faa084380a2f0d45542049a722a828180/R/utils.R#L15
.catch <- function(cnd) {
  rlang::catch_cnd(
    {
      if (rlang::is_condition(cnd)) {
        cnd[["message"]] <- cnd[["value"]]
        rlang::cnd_signal(cnd)
      }
      cnd
    },
    "extendr_err"
  )
  cnd
}
