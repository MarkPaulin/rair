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
