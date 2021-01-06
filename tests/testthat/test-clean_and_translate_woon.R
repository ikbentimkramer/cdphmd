mock_data <- tibble::tibble(
  ldl = 1,
  corop = 2,
  leeftijd = 3,
  tevrstr = 4,
  verhwens = 5,
  verleegst = 3,
  coropchar = "Test")
mockery::stub(clean_and_translate_woon, "get_data", mock_data)

test_that("No errors are thrown", {
  expect_error(clean_and_translate_woon(), NA)
})

test_that("returns coropchar column", {
  res <- clean_and_translate_woon()
  expect_true("coropchar" %in% names(res))
})

