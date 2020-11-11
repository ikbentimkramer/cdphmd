#' UI for dropdown_box_graph module
#'
#' @param id string used to namespace module
#' @param graph_ui a module ui function that takes an id argument
#' @param label the dropdown box label
#' @param choices the dropdown box choice options
#' @return an UI snippet
#' @import shiny
#' @import plotly
#' @noRd
dropdown_box_graph_ui <- function (id, graph_ui, label = "", choices = "") {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(ns("select"), label, choices),
    graph_ui(ns("graph"))
  )
}
