use extendr_api::prelude::Error;

use air_r_parser::ParseError;
use biome_formatter::diagnostics::FormatError;
use biome_formatter::diagnostics::PrintError;

pub(crate) enum RairRError {
    Parse(ParseError),
    Format(FormatError),
    Print(PrintError),
    Extendr(Error),
    Other(Box<dyn std::error::Error>),
}

impl From<RairRError> for Error {
    fn from(value: RairRError) -> Self {
        match value {
            RairRError::Parse(e) => Error::Other(e.to_string()),
            RairRError::Format(e) => Error::Other(e.to_string()),
            RairRError::Print(e) => Error::Other(e.to_string()),
            RairRError::Extendr(e) => e,
            RairRError::Other(e) => Error::Other(e.to_string()),
        }
    }
}

impl From<ParseError> for RairRError {
    fn from(value: ParseError) -> Self {
        RairRError::Parse(value)
    }
}

impl From<FormatError> for RairRError {
    fn from(value: FormatError) -> Self {
        RairRError::Format(value)
    }
}

impl From<PrintError> for RairRError {
    fn from(value: PrintError) -> Self {
        RairRError::Print(value)
    }
}

impl From<Error> for RairRError {
    fn from(value: Error) -> Self {
        RairRError::Extendr(value)
    }
}
