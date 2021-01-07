#' UI for vacancy tab
#'
#' @param woon woon survey dataframe
#'
#' @return snippet for the vacancy tab in the main UI
#' @noRd
tab_vacancy_ui <- function(woon) {
  shinydashboard::tabItem(
    "vacancy",
    shiny::fluidRow(
      shinydashboard::box(
        title = "Hoe is de leegstand van woningen in uw buurt in de afgelopen vijf jaar veranderd?",
        barplot_ui("vacancy"))))
}
