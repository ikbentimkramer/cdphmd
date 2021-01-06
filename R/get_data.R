#' Get Data From Cache or Data Source
#'
#' @param data_string A string that tells which data to get. Options
#'   are: housing_data for housing stock data.
#' @param woonpath Path to woon survey data file
#' @return a data frame containing relevant data
#' @importFrom sf st_read
#' @importFrom tibble tribble
#' @importFrom haven read_sav
#' @import dplyr
#' @noRd
get_data <- function (data_string, woonpath = "") {

  cache_path <- file.path(getwd(), "cache")
  data_path <- file.path(cache_path, paste0(data_string, ".rds"))

  lookup <- tibble::tribble(
    ~string,          ~expression,
    "housing_data",   quote(
                        clean_housing_stock_data(
                          read_housing_stock_data(),
                          get_data("municipality"))),
    "housing_price",  quote(
                        clean_housing_price_data(
                          read_housing_price_data(),
                          get_data("municipality"))),
    "municipality",   quote(read_municipality()),
    "municip_map",    quote(
                       sf::st_read(
                         paste0(
                           "https://geodata.nationaalgeoregister.nl/",
                           "cbsgebiedsindelingen/wfs",
                           "?service=wfs&version=2.0.0",
                           "&request=getFeature",
                           "&typenames=cbsgebiedsindelingen:",
                           "cbs_gemeente_2019_gegeneraliseerd",
                           "&outputFormat=json"))),
    "woon",            quote(
                         haven::read_sav(
                           woon_path) %>%
                           dplyr::filter(.data$ldl == 1) %>%
                           dplyr::mutate(
                             coropchar = as.character(
                               haven::as_factor(.data$corop)))),
    "woon_translated", quote(clean_and_translate_woon(woonpath = woonpath)))

  ## Create cache dir if it does not exist. Without showWarnings =
  ## FALSE it will warn when the directory already exists.
  dir.create(cache_path, showWarnings = FALSE)

  if (file.exists(data_path)){
    return(readRDS(data_path))
  } else {
    matches <- lookup %>%
      dplyr::filter(.data$string == data_string)
    stopifnot(nrow(matches) > 0)
    res <- matches %>%
      dplyr::pull(expression)
    res <- eval(res[[1]])
    saveRDS(res, data_path)
    res
  }
}
