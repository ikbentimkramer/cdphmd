#' UI for satisfaction tab
#'
#' @param woon woon survey dataframe
#'
#' @return snippet for the satisfaction tab in the main UI
#' @noRd
tab_satisfaction_ui <- function(woon) {
  shinydashboard::tabItem(
    "satisfaction",
    shiny::includeMarkdown(this_pkg("www/md/satisfaction.md")),
    shiny::fluidRow(
      shinydashboard::box(
        title = "Satisfaction per age group, per region",
        dropdown_box_graph_ui(
          "satisfaction1",
          barplot_ui,
          "COROP-region",
          unique(woon[,"coropchar"]))),
      shinydashboard::box(
        title = "Satisfaction per region",
        barplot_ui("satisfaction2"))))
}
