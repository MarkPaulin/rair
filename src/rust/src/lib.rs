use extendr_api::prelude::*;
use std::fs::read_to_string;

use air_r_formatter::context::RFormatOptions;
use air_r_formatter::format_node;
use air_r_parser::RParserOptions;

mod error_handling;
use error_handling::RairRError;

#[extendr]
fn format_code_(code: String) -> Result<String> {
  let options = RFormatOptions::new();
  let parse = air_r_parser::parse(&code, RParserOptions::default());

  if parse.has_error() {
    let error = parse.into_error().unwrap();
    return Err(RairRError::from(error).into());
  }

  let formatted = format_node(options, &parse.syntax()).map_err(RairRError::from)?;
  let formatted = formatted.print().map_err(RairRError::from)?;
  let formatted = formatted.into_code();
  Ok(formatted)
}


#[extendr]
fn format_file_(path: &str) -> Result<bool> {
  let old = read_to_string(path).map_err(|e| RairRError::OtherError(Box::new(e)))?;
  let formatted = format_code_(old.clone())?;

  if old.len() == formatted.len() && old == formatted {
    Ok(false)
  } else {
    std::fs::write(path, formatted).map_err(|e| RairRError::OtherError(Box::new(e)))?;
    Ok(true)
  }
}


// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod rair;
    fn format_file_;
    fn format_code_;
}
