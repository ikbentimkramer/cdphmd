#' UI for move_desire tab
#'
#' @param woon woon survey dataframe
#'
#' @return snippet for the move_desire tab in the main UI
#' @noRd
tab_move_desire_ui <- function(woon) {
  shinydashboard::tabItem(
    "move_desire",
    shiny::fluidRow(
      shinydashboard::box(
        title = "Wilt u binnen twee jaar verhuizen?",
        dropdown_box_graph_ui(
          "move_desire",
          barplot_ui,
          "COROP-regio",
          unique(woon[,"coropchar"])))))
}
