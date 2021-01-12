## Set up data
df <- data.frame(
  Gemeentecode = c(rep(1680,5), rep(14,5)),
  municip_code = c(rep("GM1680",5), rep("GM0014",5)),
  municipality = c(rep("Aa en Hunze",5), rep("Groningen",5)),
  Provinciecode = c(rep(22,5), rep(20,5)),
  ProvinciecodePV = c(rep("PV22",5), rep("PV20",5)),
  province = c(rep("Drenthe", 5), rep("Groningen", 5)),
  year = rep(c(2015, 2016, 2017, 2018, 2019), 2),
  population = c(25203, 25243, 25286, 25390, 25386, 226712, 227380, 229494, 229962, 231299),
  stringsAsFactors = FALSE
)

## Set up result
res <- filter_imputed_migration_data(df)

test_that("Cleaned df contains the right columns",{
  col_names <- c("municip_code", "municipality", "province", "2015", "2019", "Balance", "Percentage", "Change")
  expect_true(all(col_names %in% names(res)))
  expect_true(all(names(res) %in% col_names))
})

test_that("Cleaned df correctly matches municipality codes", {
  expect_equal(res[which(res[,"Balance"] == 183),
                   "municipality"], "Aa en Hunze")
})
