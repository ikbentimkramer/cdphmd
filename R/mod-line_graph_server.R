
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
#' @import plotly
#' @import stringr
#' @importFrom stats as.formula
#' @noRd
line_graph_server <- function(id, x, y, df) {
  x_str <- x
  y_str <- y
  x_form <- string2formula(x)
  y_form <- string2formula(y)
  shiny::moduleServer(id, function(input, output, session) {
    output$linegraph  <- plotly::renderPlotly({
      if (shiny::is.reactive(df)) {
        df <- df()
      }
      plotly::plot_ly(
        df,
        x = x_form,
        y = y_form,
        type = "scatter",
        mode = "lines") %>%
        plotly::layout(
          xaxis = list(title = x_str),
          yaxis = list(title = y_str))
    })
  })
}

string2formula <- function (varname_string) {
  if (stringr::str_detect(varname_string, "\\w")){
    varname_string <- paste0("`", varname_string, "`")
  }
  stats::as.formula(paste0("~", varname_string))
}
