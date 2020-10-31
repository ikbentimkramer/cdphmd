#' Line Graph Module Server
#'
#' The line graph module makes a line plot in shiny.
#'
#' @param id a string to use as namespace
#' @param df a data frame containing the data to plot
#' @param x a string that equals the name of the column in df to use
#'   on the x-axis
#' @param y a string that equals the name of the column in df to use
#'   on the y axis
#' @return a module server function
#' @import shiny
#' @import dplyr
#' @noRd
line_graph_server <- function(id, x, y, df) {

  shiny::moduleServer(id, function(input, output, session) {
    output$linegraph  <- shiny::renderPlot({
      plot(
        df %>% dplyr::pull(x),
        df %>% dplyr::pull(y),
        type = "l",
        lty = "solid")
    })
  })
}
