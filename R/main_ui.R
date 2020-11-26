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
#' @noRd
main_ui  <- function(housing_data, housing_price) {
  constants <- list(
    title = "CDPHMD")
  header <- shinydashboard::dashboardHeader(title = constants[["title"]])

  sidebar <- shinydashboard::dashboardSidebar(
    sidebarMenu(
      menuItem("General Information", tabName = "Intro", icon = icon("info")),
      menuItem("Accountability", tabName = "Acc"),
      menuItem("Registered data", icon = icon("chart-line"), tabName = "regdata",
               menuSubItem("Housing stock", tabName = "housingstock", icon = icon("building")),
               menuSubItem("Housing price", tabName = "housingprice", icon = icon("dollar-sign")),
               menuSubItem("Migration", tabName = "migration", icon = icon("people-carry"))),
      menuItem("Subjective data", tabName = "subdata",
               menuSubItem("Factor 1", tabName = "fac1"),
               menuSubItem("Factor 2", tabName = "fac2")
      )
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
      tabItem("Acc", "Accountability info"),
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
      tabItem("housingprice",
              shiny::fluidRow(
                shinydashboard::box(
                  dropdown_box_graph_ui(
                    "housing_price",
                    line_graph_ui,
                    "Municipality",
                    unique(housing_price[,"municipality"])),
                  title = "Average selling price"),
              ),
              ),
      tabItem("migration", "info about the migration"),
      tabItem("fac1", "txt1"),
      tabItem("fac2", "txt2")
    )
  )
  shinydashboard::dashboardPage(header, sidebar, body)
}

