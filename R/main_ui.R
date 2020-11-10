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
main_ui  <- function(housing_data) {
  constants <- list(
    title = "CDPHMD")
  header <- shinydashboard::dashboardHeader(title = constants[["title"]])
  
  sidebar <- shinydashboard::dashboardSidebar(
    sidebarMenu(
      menuItem("General Information", tabName = "Intro", icon = icon("info")),
      menuItem("Indicators", icon = icon("chart-line"), tabName = "indicators",
               menuSubItem("Housing stock", tabName = "housingstock", icon = icon("building")),
               menuSubItem("House Price", tabName = "houseprice", icon = icon("dollar-sign")),
               menuSubItem("Indicator 3", tabName = "Indicator3")),
      menuItem("Another item", tabName = "another")
    )
  )
  
  body <- shinydashboard::dashboardBody(
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
      tabItem(tabName = "Intro", "General overview of the dashboard"),
      tabItem("housingstock",
              shiny::fluidRow(
                shinydashboard::box(
                  dropdown_box_graph_ui(
                    "housing_stock",
                    line_graph_ui,
                    "Municipality",
                    unique(housing_data[,"municipality"])),
                  title = "Housing stock")
              )),
      tabItem("houseprice", "info about the 2nd indicator we will choose"),
      tabItem("Indicator3", "info about the 3rd indicator we will choose")
    )
  )
  shinydashboard::dashboardPage(header, sidebar, body)
}

