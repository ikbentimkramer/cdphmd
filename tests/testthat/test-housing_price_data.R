## Set up data
price <- c(10000, 13254, 320, 22222, 54321, 3, 0, 55555, 8291)
df <- data.frame(
  Perioden = rep(c("2017JJ00", "2018JJ00", "2017JJ00"), 3),
  RegioS = c(rep("GM1680", 3), rep("GM0197", 3), rep("GM0059", 3)),
  GemiddeldeVerkoopprijs_1 = price)
codes_df <- data.frame(
  GemeentecodeGM = c("GM1680","GM0197", "GM0059"),
  Provincienaam = c("Drenthe", "Groningen", "Groningen"),
  Gemeentenaam = c("Duckstad", "Mordor", "Rommeldam"))

## Set up result
res <- clean_housing_price_data(df,codes_df)

test_that("Cleaned df contains the right columns",{
  col_names <- c("municipality","province","year", "Average selling price")
  expect_true(all(col_names %in% names(res)))
  expect_true(all(names(res) %in% col_names))
})

test_that("Cleaned df correctly matches municipality codes", {
  expect_equal(res[which(res[,"Average selling price"] == 22222),
                   "municipality"], "Mordor")
  expect_length(res[which(res[,"municipality"] == "Duckstad"),
                    "Average selling price"], 3)
})
