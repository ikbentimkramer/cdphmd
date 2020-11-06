#' Main Server
#'
#' This function returns the main server function for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
main_server <- function() {
  housing_data <- clean_housing_stock_data(
    read_housing_stock_data())
  function(input, output, session) {
    line_graph_server(
      "housing_stock",
      "year",
      "housing stock",
      housing_data)
    }
}
