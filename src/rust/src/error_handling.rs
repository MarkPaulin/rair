use extendr_api::prelude::Error;

use air_r_parser::ParseError;
use biome_formatter::diagnostics::FormatError;
use biome_formatter::diagnostics::PrintError;

pub(crate) enum RairRError {
    ParseError(ParseError),
    FormatError(FormatError),
    PrintError(PrintError),
    ExtendrError(Error),
    OtherError(Box<dyn std::error::Error>),
}

impl From<RairRError> for Error {
    fn from(value: RairRError) -> Self {
        match value {
            RairRError::ParseError(e) => Error::Other(e.to_string()),
            RairRError::FormatError(e) => Error::Other(e.to_string()),
            RairRError::PrintError(e) => Error::Other(e.to_string()),
            RairRError::ExtendrError(e) => e,
            RairRError::OtherError(e) => Error::Other(e.to_string()),
        }
    }
}

impl From<ParseError> for RairRError {
    fn from(value: ParseError) -> Self {
        RairRError::ParseError(value)
    }
}

impl From<FormatError> for RairRError {
    fn from(value: FormatError) -> Self {
        RairRError::FormatError(value)
    }
}

impl From<PrintError> for RairRError {
    fn from(value: PrintError) -> Self {
        RairRError::PrintError(value)
    }
}

impl From<Error> for RairRError {
    fn from(value: Error) -> Self {
        RairRError::ExtendrError(value)
    }
}
