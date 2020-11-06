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
  shiny::addResourcePath('www', system.file('www', package = 'cdphmd'))
  shiny::shinyApp(main_ui(), main_server())
}
