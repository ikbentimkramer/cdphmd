#' UI for housing stock tab
#'
#' @param housing_data housing stock data frame
#'
#' @return snippet for the housing stock tab in the main UI
#' @noRd
tab_housingstock_ui <- function(housing_data) {
  shinydashboard::tabItem(
    "housingstock",
    shiny::includeMarkdown(this_pkg("www/md/housingstock.md")),
    shiny::fluidRow(
      shinydashboard::box(
        stock_map_ui(
          "housing_stock_map")),
      shinydashboard::box(
        dropdown_box_graph_ui(
          "housing_stock",
          line_graph_ui,
          "Municipality",
          unique(housing_data[,"municipality"])),
        title = "Housing stock")))
}
