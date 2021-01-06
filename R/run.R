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
  housing_price <- get_data("housing_price")
  mapdata <- get_data("municip_map")
  woon <- get_data("woon_translated")
  shiny::shinyApp(
    main_ui(
      housing_data,
      housing_price,
      woon),
    main_server(
      housing_data,
      housing_price,
      mapdata,
      woon))
}
