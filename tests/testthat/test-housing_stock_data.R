test_that("Correctly cleans housing stock data", {
  stock <- c(13671, 13254, 13352)
  df <- data.frame(
    Periods = c("2017JJ00", "2018JJ00", "2017JJ00"),
    Regions = c("GM1680", "GM0197", "GM0059"),
    InitialStock_1 = stock)
  codes_df <- data.frame(
    GemeentecodeGM = c("GM1680","GM0197", "GM0059"),
    Provincienaam = c("Drenthe", "Gelderland", "Friesland")
  )
  res <- clean_housing_stock_data(df,codes_df)
  expect_equal(res[["housing stock"]], 13671)
  expect_equal(res[["year"]], 2017)
})

test_that("jsonlite::read_json is called with two arguments", {
  m <- mockery::mock()
  mockery::stub(read_housing_stock_data, "jsonlite::read_json", m)
  read_housing_stock_data()
  expect_length(mockery::mock_args(m)[[1]], 2)
})
