## Set up data
df <- data.frame(
  Periods = rep(c("2015JJ00","2019JJ00"), 9),
  Regions = rep(c("GM1699", "GM1699", "GM0093", "GM0093", "GM9875", "GM9875"), 3),
  PopulationOn1January_1 = rep(c(31137,31290,4827,4890,3333,2222),3),
  stringsAsFactors = FALSE
)
codes_df <- data.frame(
  GemeentecodeGM = c("GM1699", "GM0093", "GM9875"),
  Provincienaam = c("Drenthe", "Friesland","Groningen"),
  Gemeentenaam = c("Noordenveld", "Terschelling", "Rommeldam"),
  stringsAsFactors = FALSE)

## Set up result
res <- clean_migration_data(df,codes_df)

test_that("Cleaned df contains the right columns",{
  col_names <- c("province", "municipality", "2015", "2019", "Balance")
  expect_true(all(col_names %in% names(res)))
  expect_true(all(names(res) %in% col_names))
})

test_that("Cleaned df correctly matches municipality codes", {
  expect_equal(res[which(res[,"Balance"] == 153),
                   "province"], "Noordenveld")
})

test_that("jsonlite::read_json is called with two arguments", {
  m <- mockery::mock()
  mockery::stub(read_migration_data, "jsonlite::read_json", m)
  read_migration_data()
  expect_length(mockery::mock_args(m)[[1]], 2)
})