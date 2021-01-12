#' UI for barplot migration module
#'
#' @param id string used to namespace module
#' @return an UI snippet
#' @import shiny
#' @import plotly
#' @noRd
barplot_migration_ui <- function (id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    plotly::plotlyOutput(ns("barmigrationplot"))
  )
}
