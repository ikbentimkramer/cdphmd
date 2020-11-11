## Mock all IO
exist <- mockery::mock(TRUE, FALSE, FALSE, cycle = FALSE)
mockery::stub(get_data, "file.exists", exist, 1)
mockery::stub(get_data, "dir.create", "", 1)
read <- mockery::mock("read")
mockery::stub(get_data, "readRDS", read, 3)
mockery::stub(get_data, "read_housing_stock_data", "", 4)
mockery::stub(get_data, "read_municipality", "", 4)
clean <- mockery::mock("clean")
mockery::stub(get_data, "clean_housing_stock_data", clean, 3)
save <- mockery::mock()
mockery::stub(get_data, "saveRDS", save, 2)

test_that("Local file is read if it exists", {
  expect_equal(get_data("housing_data"), "read")
})

test_that("Housing data is retrieved online and saved", {
  res <- get_data("housing_data")
  expect_equal(res, "clean")
  mockery::expect_called(save, 1)
})

test_that("Unknown strings throw error", {
  expect_error(get_data("test"))
})
