#' Main UI
#'
#' This function returns the main UI for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
main_ui  <- function() {
    shiny::fluidPage(
               shiny::textOutput("hello")
           )
}
