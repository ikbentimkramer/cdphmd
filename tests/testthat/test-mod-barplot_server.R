input <- data.frame(foo = c(1, 2, 3, 4), bar = c(5, 5, 1, 3))
test_that("barplot_server does not throw errors", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_server,
      args = list(x = "foo", y = "bar", df = input),
      {
        expect_error(output$barplot, NA)
      })
  })
})

test_that("barplot_server accepts reactives", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      barplot_server,
      args = list(x = "foo", y = "bar", df = shiny::reactive({input})),
      {
        expect_error(output$barplot, NA)
      })
  })
})
