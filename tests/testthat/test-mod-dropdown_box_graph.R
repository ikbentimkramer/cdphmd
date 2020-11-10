test_that("dropdown_box_graph_server filters input", {
  input <- data.frame(
    foo = c(1, 2, 3, 4),
    bar = c(5, 5, 1, 3),
    baz = c(1, 1, 2, 2))
  shiny::testServer(
    dropdown_box_graph_server,
    args = list(
      x = "foo",
      y = "bar",
      df = input,
      filter_col = "baz",
      graph_server = mockery::mock()),
    {
      session$setInputs(select = 1)
      expect_equal(filtered_df()[,"foo"], c(1,2))
      expect_equal(filtered_df()[,"bar"], c(5,5))
    })
})
