## Mock all IO
read <- mockery::mock("read")
mockery::stub(get_data, "readRDS", read, 1)
save <- mockery::mock()
mockery::stub(get_data, "saveRDS", save, 2)
evalmock <- mockery::mock()
mockery::stub(get_data, "eval", evalmock, 1)

test_that("Local file is read if it exists", {
  mockery::stub(get_data, "file.exists", TRUE, 1)
  expect_equal(get_data("housing_data"), "read")
})

## Mock file.exists to FALSE
mockery::stub(get_data, "file.exists", mockery::mock(FALSE, cycle = TRUE), 1)

test_that("saveRDS is being called when supplied valid data_strings", {
  get_data("housing_data")
  get_data("housing_price")
  get_data("municipality")
  mockery::expect_called(save, 3)
})

test_that("Unknown strings throw error", {
  expect_error(get_data("test"))
})
