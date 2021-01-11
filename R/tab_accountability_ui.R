#' UI snippet for accountability section
#'
#' @return a UI snippet
#' @noRd
tab_accountability_ui <- function() {
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
              style = "width: 100%"))))
}
