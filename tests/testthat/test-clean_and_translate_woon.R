test_that("No errors are thrown", {
  mock_data <- tibble::tibble(
    ldl = 1,
    corop = 2,
    leeftijd = 3,
    tevrstr = 4,
    verhwens = 5,
    verleegst = 3)
  mockery::stub(clean_and_translate_woon, "get_data", mock_data)
  expect_error(clean_and_translate_woon, NA)
})
