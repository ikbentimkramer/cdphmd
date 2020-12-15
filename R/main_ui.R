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
    shinydashboard::sidebarMenu(
      shinydashboard::menuItem(
        "General Information",
        tabName = "Intro",
        icon = icon("info")),

      shinydashboard::menuItem(
        "Accountability",
        tabName = "Acc"),

      shinydashboard::menuItem(
        "Registered data",
        icon = icon("chart-line"),
        tabName = "regdata",
        shinydashboard::menuSubItem(
          "Housing stock",
          tabName = "housingstock",
          icon = icon("building")),
        shinydashboard::menuSubItem(
          "Housing price",
          tabName = "housingprice",
          icon = icon("dollar-sign")),
        shinydashboard::menuSubItem(
          "Migration",
          tabName = "migration",
          icon = icon("people-carry"))),

      shinydashboard::menuItem(
        "Subjective data",
        tabName = "subdata",
        shinydashboard::menuSubItem(
          "Satisfaction",
          tabName = "satisfaction"),
        shinydashboard::menuSubItem(
          "Factor 2",
          tabName = "fac2")
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
    shinydashboard::tabItems(
      shinydashboard::tabItem(
        tabName = "Intro",
        shiny::includeMarkdown(this_pkg("inst/www/md/intro.md"))),
      shinydashboard::tabItem(
        tabName = "Acc",
        shiny::includeMarkdown(this_pkg("www/md/accountability.md"))),
      shinydashboard::tabItem(
        "housingstock",
        shiny::fluidRow(
          shiny::includeMarkdown(this_pkg("www/md/housingstock.md"))),
        shiny::fluidRow(
          shinydashboard::box(
            stock_map_ui(
              "housing_price_map")),
            dropdown_box_graph_ui(
              "housing_stock",
              line_graph_ui,
              "Municipality",
              unique(housing_data[,"municipality"])),
            title = "Housing stock")),
      shinydashboard::tabItem(
        "housingprice",
        shiny::fluidRow(
          shiny::includeMarkdown(this_pkg("www/md/housingprice.md"))),
        shiny::fluidRow(
          shinydashboard::box(
            dropdown_box_graph_ui(
              "housing_price",
              line_graph_ui,
              "Municipality",
              unique(housing_price[,"municipality"])),

            title = "Average selling price"))),
      shinydashboard::tabItem(
        "migration",
        shiny::fluidRow(
          shiny::includeMarkdown(this_pkg("www/md/migration.md")))),
      shinydashboard::tabItem(
        "satisfaction",
        shiny::fluidRow(
          shiny::includeMarkdown(this_pkg("www/md/satisfaction.md"))),
        shiny::fluidRow(
          shinydashboard::box(
          barplot_ui("satisfaction1")))),
      shinydashboard::tabItem(
        "fac2",
        "txt2")))
  shinydashboard::dashboardPage(header, sidebar, body)
}

