test_that("No errors are thrown for accessing an existing file", {
  expect_error(this_pkg("www/css/cdphmd.css"), NA)
})
