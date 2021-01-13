#' UI for move_desire tab
#'
#' @param woon woon survey dataframe
#'
#' @return snippet for the move_desire tab in the main UI
#' @noRd
tab_move_desire_ui <- function(woon) {
  shinydashboard::tabItem(
    "move_desire",
    shiny::includeMarkdown(this_pkg("www/md/willingtomove.md")),
    shiny::fluidRow(
      shinydashboard::box(
        title = "Desire to move per age group, per region",
        dropdown_box_graph_ui(
          "move_desire1",
          barplot_ui,
          "COROP-regio",
          unique(woon[,"coropchar"]))),
      shinydashboard::box(
        title = "Desire to move per region",
        barplot_ui("move_desire2"))),
    shiny::fluidRow(
        shinydashboard::box(width = 12,
                            shiny::includeMarkdown(this_pkg("www/md/movedesire1.md")))))
}