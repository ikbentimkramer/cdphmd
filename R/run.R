#' Start Dashboard
#'
#' This function starts the dashboard.
#'
#' @param woondata The path to the woon data file
#'
#' @examples
#' \dontrun{
#' run()
#' }
#' @import shiny
#' @export
run  <- function(woondata = file.path(getwd(), "cache", "WoON2018_e_1.0.sav")) {
  shiny::addResourcePath('www', system.file('www', package = 'cdphmd'))

  ## Using imputed data
  imputed_data <- get_data("register_imputed")
  housing_data <- imputed_data
  housing_price <- imputed_data

  ## To use non-imputed data, remove the above lines and uncomment the
  ## following lines:
  # housing_data <- get_data("housing_data")
  # housing_price <- get_data("housing_price")

  mapdata <- get_data("municip_map")
  woon <- get_data("woon_translated", woonpath = woondata)
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
