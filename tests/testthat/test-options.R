test_that("line_width is used", {
  expect_equal(
    format_code("1234567890 + 1234567890", line_width = 10),
    "1234567890 +\n  1234567890\n"
  )

  expect_equal(
    format_code("1234567890 + 1234567890", line_width = 1000),
    "1234567890 + 1234567890\n"
  )
})

test_that("indent_width is used", {
  expect_equal(
    format_code("foo |>\nbar()", indent_width = 3),
    "foo |>\n   bar()\n"
  )
})

test_that("indents can be tabs", {
  expect_equal(
    format_code("foo |>\n  bar()", indent_style = "tab"),
    "foo |>\n\tbar()\n"
  )  
})

test_that("persistent_line_breaks can be disallowed", {
  code <- "dictionary <- list(
  apple = 0.75,
  banana = 0.25,
  cherry = 0.50
)
"

  one_line <- "dictionary <- list(apple = 0.75, banana = 0.25, cherry = 0.50)\n"

  expect_equal(format_code(code), code)
  expect_equal(format_code(code, persistent_line_breaks = FALSE), one_line)
})
