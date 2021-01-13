#' UI for vacancy tab
#'
#' @param woon woon survey dataframe
#'
#' @return snippet for the vacancy tab in the main UI
#' @noRd
tab_vacancy_ui <- function(woon) {
  shinydashboard::tabItem(
    "vacancy",
    shiny::includeMarkdown(this_pkg("www/md/vacancy.md")),
    shiny::fluidRow(
      shinydashboard::box(
        title = "Percieved vacancy per age group, per region",
        dropdown_box_graph_ui(
          "vacancy1",
          barplot_ui,
          "COROP-regio",
          unique(woon[,"coropchar"]))),
      shinydashboard::box(
        title = "Percieved vacancy per region",
        barplot_ui("vacancy2"))),
    shiny::fluidRow(
        shinydashboard::box(width = 12,
                            shiny::includeMarkdown(this_pkg("www/md/vacancy1.md")))))
}
