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
  housing_data <- get_data("housing_data")
  shiny::shinyApp(main_ui(housing_data), main_server(housing_data))
}
