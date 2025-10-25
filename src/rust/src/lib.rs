use extendr_api::prelude::*;
use extendr_macros::TryFromRobj;
use std::fs::read_to_string;

use air_r_formatter::context::RFormatOptions;
use air_r_formatter::format_node;
use air_r_parser::RParserOptions;
use settings::LineWidth;

mod error_handling;
use error_handling::RairRError;

#[derive(Debug, Clone, TryFromRobj)]
struct FormatOptions {
  pub line_width: Option<u16>,
}

impl FormatOptions {
  fn to_r_format_options(&self) -> RFormatOptions {
    let line_width = match self.line_width {
      Some(value) => LineWidth::try_from(value).unwrap_or_default(),
      None => LineWidth::default()
    };

    RFormatOptions::new()
      .with_line_width(line_width)
  }
}

#[extendr]
fn format_code_(code: String, options: FormatOptions) -> Result<String> {
  let options = options.to_r_format_options();
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
fn format_file_(path: &str, options: FormatOptions) -> Result<bool> {
  let old = read_to_string(path).map_err(|e| RairRError::OtherError(Box::new(e)))?;
  let formatted = format_code_(old.clone(), options)?;

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
