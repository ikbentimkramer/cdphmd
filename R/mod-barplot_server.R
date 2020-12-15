#' Barplot Module Server
#'
#' The barplot module server makes a barplot in shiny
#'
#' @param id a string to use as namespace
#' @param df a data frame containing the data to plot
#' @param x a string that equals the name of the column in df to use
#'   on the x-axis
#' @param y a string that equals the name of the column in df to use
#'   on the y axis
#' @return a module server function
#' @import shiny
#' @import plotly
#' @import stringr
#' @import ggplot2
#' @importFrom stats as.formula
#' @importFrom forcats fct_rev
#' @importFrom haven as_factor
#' @importFrom rlang sym
#' @importFrom rlang !!
#' @noRd
barplot_server <- function(id, x, y, df) {
  cbs_colors_cold <- c(
  "#0dc0e3",
  "#0153ac",
  "#a3cf44",
  "#44b94a",
  "#ff9629",
  "#af2b97")
  x_sym <- rlang::sym(x)
  y_sym <- rlang::sym(y)

  shiny::moduleServer(id, function(input, output, session) {
    output$barplot  <- plotly::renderPlotly({
  #    if (shiny::is.reactive(df)) {
  #      df <- df()
  #    }
      plot <- ggplot2::ggplot(
        df,
        ggplot2::aes(
          y = forcats::fct_rev(haven::as_factor(!!y_sym)),
          fill = haven::as_factor(!!x_sym))) +
        ggplot2::geom_bar(
          ggplot2::aes(
            x = round(100 * ..count../sum(..count..), 1)),
          position = ggplot2::position_dodge2(padding = 0.1),
          orientation = "y") +
        ggplot2::ylab(ggplot2::element_blank()) +
        ggplot2::xlab("%") +
        ggplot2::scale_fill_discrete(type = cbs_colors_cold) +
        ggplot2::scale_x_continuous(expand = c(0,0.5)) +
        ggplot2::theme(
          legend.position = "bottom",
          legend.justification = c(1,0.5),
          legend.box.spacing = ggplot2::unit(5, "pt"),
          legend.text.align = 0,
          legend.direction = "horizontal",
          legend.background = ggplot2::element_rect(fill = "#FFFFFF"),
          legend.box.background = ggplot2::element_blank(),
          legend.box.margin = ggplot2::margin(0, 0, 0, -250),
          legend.spacing.x = ggplot2::unit(5, "pt"),
          legend.spacing.y = ggplot2::unit(0, "pt"),
          legend.title = ggplot2::element_blank(),
          axis.ticks = ggplot2::element_blank(),
          axis.title.x = ggplot2::element_text(
            colour = "#85878b",
            hjust = 0.95,
            margin = ggplot2::margin(5,20,5,0,)),
          axis.title.y = ggplot2::element_blank(),
          panel.background = ggplot2::element_blank(),
          panel.grid.major.x = ggplot2::element_line(
            colour = "#85878b",
            linetype = "solid"),
          panel.grid.major.y = ggplot2::element_blank(),
          panel.grid.minor.y = ggplot2::element_blank())

      plotly::ggplotly(plot)
    })
  })
}
