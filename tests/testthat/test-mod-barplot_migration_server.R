## Set up data
input <- data.frame(
  Gemeentecode = c(rep(1680,5), rep(14,5)),
  municip_code = c(rep("GM1680",5), rep("GM0014",5)),
  municipality = c(rep("Aa en Hunze",5), rep("Groningen",5)),
  Provinciecode = c(rep(22,5), rep(20,5)),
  ProvinciecodePV = c(rep("PV22",5), rep("PV20",5)),
  province = c(rep("Drenthe", 5), rep("Groningen", 5)),
  year = rep(c(2015, 2016, 2017, 2018, 2019), 2),
  population = c(25203, 25243, 25286, 25390, 25386, 226712, 227380, 229494, 229962, 231299),
  Percentage = rep(2,10),
  Change = rep(33,10),
  stringsAsFactors = FALSE
)

test_that("barplot_migration_server does not throw errors", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_migration_server,
      args = list(x = "Percentage", y = "municipality", df = input),
      {
        expect_error(output$barplotmigration, NA)
      })
  })
})
test_that("barplot_migration_server accepts reactives", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_migration_server,
      args = list(x = "Percentage", y = "municipality", df = shiny::reactive({input})),
      {
        expect_error(output$barplotmigration, NA)
      })
  })
})
