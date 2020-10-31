test_that("Correctly cleans housing stock data", {
  stock <- c(141324, 32345, 123)
  df <- data.frame(
    Periods = c("2015JJ00", "2016JJ00", "1999JJ00"),
    Regions = rep("LD01  ", 3),
    InitialStock_1 = stock)
  res <- clean_housing_stock_data(df)
  expect_null(res[["Regions"]])
  expect_equal(res[["housing stock"]], stock)
  expect_equal(res[["year"]], c(2015, 2016, 1999))
})

test_that("jsonlite::read_json is called with two arguments", {
  m <- mockery::mock()
  mockery::stub(read_housing_stock_data, "jsonlite::read_json", m)
  read_housing_stock_data()
  expect_length(mockery::mock_args(m)[[1]], 2)
})
