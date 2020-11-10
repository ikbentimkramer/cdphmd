input <- data.frame(foo = c(1, 2, 3, 4), bar = c(5, 5, 1, 3))
test_that("line_graph_server does not throw errors", {
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
test_that("line_graph_server accepts reactives", {
  shiny::testServer(
    line_graph_server,
    args = list(x = "foo", y = "bar", df = shiny::reactive({input})),
    {
      expect_error(output$linegraph, NA)
    })
})
