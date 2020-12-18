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
#' @importFrom ggplot2 ggplot aes geom_bar position_dodge2 ylab
#'   element_blank xlab scale_fill_discrete scale_x_continuous theme
#'   unit element_rect margin element_line
#' @importFrom stats as.formula
#' @importFrom forcats fct_rev
#' @importFrom haven as_factor
#' @importFrom rlang sym
#' @importFrom rlang !! :=
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
      if (shiny::is.reactive(df)) {
        df <- df()
      }
      df <- df %>%
        dplyr::mutate(
          !!y_sym := forcats::fct_rev(haven::as_factor(!!y_sym)),
          !!x_sym := haven::as_factor(!!x_sym)) %>%
        dplyr::group_by(!!y_sym, !!x_sym) %>%
        dplyr::summarize(n = dplyr::n(), .groups = "keep") %>%
        dplyr::ungroup()

      plot <- ggplot2::ggplot(
        df,
        ggplot2::aes(
          y = !!y_sym,
          x = .data$n,
          fill = !!x_sym,
          text = paste0(
            as.character(!!x_sym),
            ": ",
            .data$n,
            dplyr::if_else(
              .data$n == 1,
              " persoon",
              " personen")))) +
        ggplot2::geom_bar(
          stat = "identity",
          position = ggplot2::position_dodge2(
            padding = 0.1,
            preserve = "single"),
          orientation = "y") +
        ggplot2::ylab(ggplot2::element_blank()) +
        ggplot2::xlab("Aantal") +
        ggplot2::scale_fill_discrete(type = cbs_colors_cold) +
        ggplot2::scale_x_continuous(expand = c(0,0.5)) +
        ggplot2::theme(
          legend.position = "left",
          legend.justification = c(1,0.5),
          legend.box.spacing = ggplot2::unit(5, "pt"),
          legend.text.align = 0,
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

        fig <- plotly::ggplotly(plot, tooltip = c("text"))
        fig <- fig %>%
          plotly::layout(
            xaxis = list(
              fixedrange = TRUE,
              tickfont = list(size = 10)),
            yaxis = list(
              fixedrange = TRUE,
              tickfont = list(size =10)),
            legend = list(
              x = -0.1,
              y = 100,
              orientation = "h",
              font = list(size = 10))) %>%
          plotly::config(
            displayModeBar = FALSE)
        fig
    })
  })
}
