input <- data.frame(xax = c(1, 2, 3, 4), yax = c(5, 5, 1, 3))
test_that("barplot_server does not throw errors", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_migration_server,
      args = list(x = "xax", y = "yax", df = input),
      {
        expect_error(output$barplot, NA)
      })
  })
})
test_that("barplot_server accepts reactives", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_migration_server,
      args = list(x = "xax", y = "yax", df = shiny::reactive({input})),
      {
        expect_error(output$barplot, NA)
      })
  })
})
