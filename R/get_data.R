#' Get Data From Cache or Data Source
#'
#' @param data_string A string that tells which data to get. Options
#'   are: housing_data for housing stock data.
#' @return a data frame containing relevant data
#' @importFrom tibble tribble
#' @import dplyr
#' @noRd
get_data <- function (data_string) {
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
    "municipality",   quote(read_municipality()))

  cache_path <- file.path(getwd(), "cache")
  data_path <- file.path(cache_path, paste0(data_string, ".rds"))
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
      dplyr::pull(expression) %>%
      eval()
    saveRDS(res, data_path)
  }
}

