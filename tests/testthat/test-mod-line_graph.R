input <- data.frame(foo = c(1, 2, 3, 4), bar = c(5, 5, 1, 3))
test_that("line_graph_server does not throw errors", {
  rlang::with_options(lifecycle_verbosity = "quiet", {
    shiny::testServer(
      line_graph_server,
      args = list(x = "foo", y = "bar", df = input),
      {
        expect_error(output$linegraph, NA)
      })
  })
})

test_that("line_graph_server throws a dplyr deprication warning", {
  rlang::with_options(lifecycle_verbosity = "warning", {
    shiny::testServer(
      line_graph_server,
      args = list(x = "foo", y = "bar", df = input),
      {
        expect_warning(output$linegraph, "dplyr")
      })
  })
})

test_that("column name strings get converted to formulas correctly",{
  expect_equal(string2formula("foo"), ~foo)
  expect_equal(string2formula(" foo"), ~` foo`)
  expect_equal(string2formula("foo "), ~`foo `)
  expect_equal(string2formula("foo bar"), ~`foo bar`)
})
