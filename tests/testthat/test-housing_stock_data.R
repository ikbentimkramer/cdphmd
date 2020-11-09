## Set up data
stock <- c(10000, 13254, 320, 22222, 54321, 3, 0, 55555, 8291)
df <- data.frame(
  Periods = rep(c("2017JJ00", "2018JJ00", "2017JJ00"), 3),
  Regions = c(rep("GM1680", 3), rep("GM0197", 3), rep("GM0059", 3)),
  InitialStock_1 = stock)
codes_df <- data.frame(
  GemeentecodeGM = c("GM1680","GM0197", "GM0059"),
  Provincienaam = c("Drenthe", "Groningen", "Groningen"),
  Gemeentenaam = c("Duckstad", "Minas Tirith", "Rommeldam"))

## Set up result
res <- clean_housing_stock_data(df,codes_df)

test_that("Cleaned df contains the right columns",{
  col_names <- c("year", "housing stock", "province", "municipality")
  expect_true(all(col_names %in% names(res)))
  expect_true(all(names(res) %in% col_names))
})

test_that("Cleaned df correctly matches municipality codes", {
  expect_equal(res[which(res[,"housing stock"] == 22222),
    "municipality"], "Minas Tirith")
  expect_length(res[which(res[,"municipality"] == "Duckstad"),
    "housing stock"], 3)
})

test_that("jsonlite::read_json is called with two arguments", {
  m <- mockery::mock()
  mockery::stub(read_housing_stock_data, "jsonlite::read_json", m)
  read_housing_stock_data()
  expect_length(mockery::mock_args(m)[[1]], 2)
})
