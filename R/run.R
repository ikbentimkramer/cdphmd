#' Start Dashboard
#'
#' This function starts the dashboard.
#'
#' @examples
#' \dontrun{
#' run()
#' }
#' @import shiny
#' @export
run  <- function() {
    shiny::shinyApp(main_ui(), main_server())
}
