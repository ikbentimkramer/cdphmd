#' Intro tab UI snippet
#' @return An UI snippet
#' @noRd
tab_intro_ui <- function() {
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
            shiny::includeMarkdown(this_pkg("www/md/intro.md")))))
}
