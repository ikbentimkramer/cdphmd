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
main_ui  <- function(housing_data, housing_price, woon) {
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
          "Desire to move",
          tabName = "move_desire"),
        shinydashboard::menuSubItem(
          "Vacancy rate",
          tabName = "vacancy")
      ),
      shinydashboard::menuItem(
        "Downloads",
        tabName = "download")
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
        shiny::fluidRow(
          shinydashboard::box(
            width = 12,
            shiny::img(
              src = "./www/images/reitdiephaven-groningen-free-license-cc0.jpg",
              alt = "Colourful houses on the waterside",
              style = "width: 100%"))),
        shiny::fluidRow(
          shinydashboard::box(
            width = 12,
            shiny::includeMarkdown(this_pkg("inst/www/md/intro.md"))))),

      shinydashboard::tabItem(
        tabName = "Acc",
        shiny::fluidRow(
          shinydashboard::box(
            width = 12,
            shiny::includeMarkdown(this_pkg("www/md/accountability.md")))),
        shiny::fluidRow(
          shinydashboard::box(
            width = 3,
            shiny::img(
              alt = "Logo Rijksuniversiteit Groningen",
              src = "./www/images/rugr_logoenv_rood_rgb.png",
              style = "width: 100%")),
          shinydashboard::box(
            width = 6,
            shiny::img(
              alt = "Logo minor Data Wise",
              src = "./www/images/datawise-logo.png",
              style = "width: 100%")),
          shinydashboard::box(
            width = 3,
            shiny::img(
              alt = "Logo CBS",
              src = "./www/images/cbs-ld-logo.png",
              style = "width: 100%")))),

      shinydashboard::tabItem(
        tabName = "download",
        shiny::includeMarkdown(this_pkg("www/md/download.md"))),

      tab_housingstock_ui(housing_data),

      tab_housingprice_ui(housing_price),

      shinydashboard::tabItem(
        "migration",
        shiny::includeMarkdown(this_pkg("www/md/migration.md"))),

      tab_satisfaction_ui(woon),

      tab_move_desire_ui(woon),

      tab_vacancy_ui(woon)))

    shinydashboard::dashboardPage(header, sidebar, body)
  }

