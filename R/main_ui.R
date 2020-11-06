#' Main UI
#'
#' This function returns the main UI for this dashboard.
#' @param housing_data housing stock data
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
#' @import shinydashboard
#' @noRd
main_ui  <- function(housing_data) {
  constants <- list(
    title = "CDPHMD")
  shinydashboard::dashboardPage(
    shinydashboard::dashboardHeader(title = constants[["title"]]),
    shinydashboard::dashboardSidebar(),
    shinydashboard::dashboardBody(
      tags$head(
        tags$link(
          href = "https://fonts.googleapis.com/css2?family=Bree+Serif&display=swap",
          rel = "stylesheet",
          type = "text/css"),
        tags$link(
          href = "www/css/cdphmd.css",
          rel = "stylesheet",
          type = "text/css")
      ),
      shiny::fluidRow(
        shinydashboard::box(
          dropdown_box_graph_ui(
            "housing_stock",
            line_graph_ui,
            "Municipalities",
            unique(housing_data[[,"municipalities"]])),
          title = "Housing stock")
      )
    )
  )
}
