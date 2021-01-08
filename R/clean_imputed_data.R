#' Transform imputed data to dashboard usable format
#'
#' @param raw the raw imputed data
#'
#' @return a tibble usable by the dashboard
#' @import dplyr
#' @importFrom rlang .data
#' @importFrom lubridate year
#' @noRd

clean_imputed_data <- function(raw) {
  raw %>%
    dplyr::rename(
      municip_code = .data$GemeentecodeGM,
      municipality = .data$Gemeentenaam,
      province = .data$Provincienaam,
      `housing stock` = .data$imputed_stock,
      `Average selling price` = .data$imputed_price,
      population = .data$imputed_population) %>%
    dplyr::mutate(
      year = lubridate::year(.data$stock_date),
      `housing stock` = as.numeric(.data$`housing stock`),
      `Average selling price` = as.numeric(.data$`Average selling price`),
      population = as.numeric(.data$population))
}
