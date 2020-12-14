#' Main Server
#'
#' This function returns the main server function for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
#' @noRd
main_server <- function(housing_data, housing_price) {
  function(input, output, session) {
    dropdown_box_graph_server(
      "housing_stock",
      "year",
      "housing stock",
      housing_data,
      "municipality",
      line_graph_server)

    dropdown_box_graph_server(
      "housing_price",
      "year",
      "Average selling price",
      housing_price,
      "municipality",
      line_graph_server)

    stock_map_server("housing_price_map")
  }
}
