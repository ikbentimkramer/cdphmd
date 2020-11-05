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
    shinydashboard::dashboardSidebar(
      sidebarMenu(
      # Setting id makes input$tabs give the tabName of currently-selected tab
      id = "tabs",
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Housing Stock", icon = icon("building"), 
               menuSubItem("Municipalities of Groningen", tabName = "GR", ),
               menuSubItem("Municipalities of Drenthe", tabName = "DR")
      )
      )
      
    ),
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
        tabItems(
          tabItem(tabName = "GR",
                shiny::fluidRow(
                  shinydashboard::box(
                    line_graph_ui("housing_stock"),
                    title = "Housing stock")
                )
              ),
        tabItem(tabName = "DR",
          h2("text2")
        )
      )
    )
  )
}
