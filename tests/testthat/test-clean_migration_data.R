## Set up data
df <- data.frame(
  Periods = c("2015JJ00", "2019JJ00", "2015JJ00", "2019JJ00", "2015JJ00", "2019JJ00"),
  Regions = c("GM1699", "GM1699", "GM0093", "GM0093", "GM9875", "GM9875"),
  PopulationOn1January_1 = c(31137, 31290, 4827, 4890, 3333, 2222),
  stringsAsFactors = FALSE
)
codes_df <- codes_df <- data.frame(
  GemeentecodeGM = c(rep("GM1699",2), rep("GM0093",2), rep("GM9875",2)),
  Provincienaam = c(rep("Drenthe",2), rep("Friesland",2), rep("Groningen",2)),
  Gemeentenaam = c(rep("Noordenveld",2), rep("Terschelling", 2), rep("Rommeldam",2)),
  stringsAsFactors = FALSE)

## Set up result
res <- clean_migration_data(df,codes_df)

test_that("Cleaned df contains the right columns",{
  col_names <- c("municipality", "province", "2015", "2019", "Balance")
  expect_true(all(col_names %in% names(res)))
  expect_true(all(names(res) %in% col_names))
})

test_that("Cleaned df correctly matches municipality codes", {
  expect_equal(res[which(res[,"Balance"] == 153),
                   "municipality"], "Noordenveld")
})

test_that("jsonlite::read_json is called with two arguments", {
  m <- mockery::mock()
  mockery::stub(read_migration_data, "jsonlite::read_json", m)
  read_migration_data()
  expect_length(mockery::mock_args(m)[[1]], 2)
})