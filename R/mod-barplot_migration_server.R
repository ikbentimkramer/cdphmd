#' Barplot for the migration indicator Module Server
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
#' @importFrom ggplot2 ggplot aes geom_bar xlab
#'   element_blank xlab theme element_line
#' @noRd
barplot_migration_server <- function(id, df, x, y){
  myplots <- vector('list', 3)
  
  shiny::moduleServer(id, function(input, output, session) {
    output$barplot_migration  <- plotly::renderPlotly({
      for (i in 1:3){
        x = c("Groningen", "Drenthe", "Friesland")
      df_subs <- df[df$province == x[i], ]
          if (shiny::is.reactive(df_subs)) {
            df_subs <- df_subs()
          }
          
          plot <- ggplot2::ggplot(data = df_subs,
                                 aes(x = Percentage, y = reorder(municipality, Percentage),
                                     fill = Change))+
                            geom_bar(stat = "identity")+ 
                            theme(
                              plot.background = element_blank(),
                              panel.background = element_blank(),
                              panel.border = element_blank(),
                              panel.grid.major = element_line(size = 0.5, linetype = 'dotted',
                                                              colour = "black"),
                              axis.title.y = element_blank(),
                              panel.grid.minor = element_blank(),
                              axis.line = element_line(colour = "black"))+
                            xlab("Percentage change")
                            myplots[[i]] <- plot
        fig <- plotly::ggplotly(myplots)
        fig
          }
      })
  })
}

