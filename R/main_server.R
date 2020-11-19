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
main_server <- function(housing_data) {
  function(input, output, session) {
    dropdown_box_graph_server(
      "housing_stock",
      "year",
      "housing stock",
      housing_data,
      "municipality",
      line_graph_server)
    }
}
