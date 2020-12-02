## Mock all IO
read <- mockery::mock("read")
mockery::stub(get_data, "readRDS", read, 1)
mockery::stub(get_data, "read_housing_stock_data", "", 4)
mockery::stub(get_data, "read_housing_price_data", "", 4)
mockery::stub(get_data, "read_municipality", "", 4)
clean_stock <- mockery::mock("clean stock", cycle = TRUE)
mockery::stub(get_data, "clean_housing_stock_data", clean_stock, 3)
clean_price <- mockery::mock("clean price", cycle = TRUE)
mockery::stub(get_data, "clean_housing_price_data", clean_price, 3)

test_that("Local file is read if it exists", {
  mockery::stub(get_data, "file.exists", TRUE, 1)
  expect_equal(get_data("housing_data"), "read")
})

mockery::stub(get_data, "file.exists", mockery::mock(FALSE, cycle = TRUE), 1)

test_that("Housing stock data is retrieved online and saved", {
  save <- mockery::mock()
  mockery::stub(get_data, "saveRDS", save, 2)

  res <- get_data("housing_data")
  expect_equal(res, "clean stock")
  mockery::expect_called(save, 1)
})

test_that("Housing price data is retrieved online and saved", {
  ## Reset save counter
  save <- mockery::mock()
  mockery::stub(get_data, "saveRDS", save, 2)

  res <- get_data("housing_price")
  expect_equal(res, "clean price")
  mockery::expect_called(save, 1)
})

test_that("Unknown strings throw error", {
  expect_error(get_data("test"), "unknown data_string: test")
})
