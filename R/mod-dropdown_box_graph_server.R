#' Dropdown Box Graph Module Server
#'
#' The dropdown_box_graph server adds a dropdown plot to a graph
#'
#' @param id a string to use as namespace
#' @param df a data frame containing the data to plot
#' @param x a string that equals the name of the column in df to use
#'   on the x-axis
#' @param y a string that equals the name of the column in df to use
#'   on the y axis
#' @param filter_col the column in df that should be filtered on using
#'   the dropdown box.
#' @param graph_server a module server function that draws the graph
#' @return a module server function
#' @import shiny
#' @import dplyr
#' @import plotly
#' @import stringr
#' @importFrom stats as.formula
#' @noRd
dropdown_box_graph_server <- function(id,
                                      x = "",
                                      y = "",
                                      df = NULL,
                                      filter_col = "",
                                      graph_server = NULL) {
  shiny::moduleServer(id, function (input, output, session) {
    filtered_df <- reactive({
      df[which(df[,filter_col] == input$select),]
    })
    graph_server("graph", x, y, filtered_df)
  })
}
