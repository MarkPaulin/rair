test_that("code is formatted", {
  old <- "\n 3+   2"
  exp <- "3 + 2\n"
  expect_equal(
    format_code(old),
    exp
  )
})

test_that("files are formatted", {
  withr::with_file("test.R", {
    readr::write_file("\n 3+   2", "test.R")
    expect_true(format_file("test.R"))
    expect_false(format_file("test.R"))

    exp <- "3 + 2\n"
    out <- readr::read_file("test.R")
    expect_equal(out, exp)
  })
})

test_that("errors", {
  expect_error(
    format_code("+-293201i/"),
    "Failed to parse due to syntax errors"
  )

  withr::with_file("test.R", {
    writeLines("+-293201i/", "test.R")
    expect_error(
      format_file("test.R"),
      "Failed to parse due to syntax errors"
    )
  })

  withr::with_dir(tempdir(), {
    expect_error(format_file("doesnotexist.R"))
  })
})
