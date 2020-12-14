#' Get Data From Cache or Data Source
#'
#' @param data_string A string that tells which data to get. Options
#'   are: housing_data for housing stock data.
#' @return a data frame containing relevant data
#' @importFrom sf st_read
#' @noRd
get_data <- function (data_string) {
  cache_path <- file.path(getwd(), "cache")
  data_path <- file.path(cache_path, paste0(data_string, ".rds"))
  ## Create cache dir if it does not exist. Without showWarnings =
  ## FALSE it will warn when the directory already exists.
  dir.create(cache_path, showWarnings = FALSE)
  if (file.exists(data_path)){
    return(readRDS(data_path))
  }
  if (data_string == "housing_data") {
    res <- clean_housing_stock_data(
      read_housing_stock_data(),
      read_municipality())
    saveRDS(res, data_path)
    return(res)
  }
  if (data_string == "housing_price"){
    res <- clean_housing_price_data(
      read_housing_price_data(),
      read_municipality())
    saveRDS(res, data_path)
    return(res)
  }
  if (data_string == "municip_map") {
    res <- sf::st_read(
      paste0(
        "https://geodata.nationaalgeoregister.nl/",
        "cbsgebiedsindelingen/wfs?service=wfs&version=2.0.0",
        "&request=getFeature",
        "&typenames=cbsgebiedsindelingen:cbs_gemeente_2019_gegeneraliseerd",
        "&outputFormat=json"))
    saveRDS(res, data_path)
    return(res)
  }
  stop(paste0("unknown data_string: ", data_string))
}

