#' Main UI
#'
#' This function returns the main UI for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
#' @import shinydashboard
main_ui  <- function() {
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
          line_graph_ui("housing_stock"),
          title = "Housing stock")
      )
    )
  )
}
