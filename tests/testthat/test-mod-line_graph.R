test_that("line_graph_server does not throw errors", {
  input <- data.frame(foo = c(1, 2, 3, 4), bar = c(5, 5, 1, 3))
  shiny::testServer(
    line_graph_server,
    args = list(x = "foo", y = "bar", df = input),
    {
      expect_error(output$linegraph, NA)
    })
})
test_that("column name strings get converted to formulas correctly",{
  expect_equal(string2formula("foo"), ~foo)
  expect_equal(string2formula(" foo"), ~` foo`)
  expect_equal(string2formula("foo "), ~`foo `)
  expect_equal(string2formula("foo bar"), ~`foo bar`)
})
