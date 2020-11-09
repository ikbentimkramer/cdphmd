#' UI for linegraph module
#'
#' @param id string used to namespace module
#' @return an UI snippet
#' @import shiny
#' @import plotly
#' @noRd
line_graph_ui <- function (id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    plotly::plotlyOutput(ns("linegraph"))
  )
}
