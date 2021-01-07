#' UI for housing price tab
#'
#' @param housing_price housing price dataframe
#'
#' @return snippet for the housing price tab in the main UI
#' @noRd
tab_housingprice_ui <- function(housing_price) {
  shinydashboard::tabItem(
    "housingprice",
    shiny::includeMarkdown(this_pkg("www/md/housingprice.md")),
    shiny::fluidRow(
      shinydashboard::box(
        price_map_ui(
          "housing_price_map")),
      shinydashboard::box(
        dropdown_box_graph_ui(
          "housing_price",
          line_graph_ui,
          "Municipality",
          unique(housing_price[,"municipality"])),
        title = "Average selling price")))
}
