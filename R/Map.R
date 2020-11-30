test_map_f <- function() {
  test <- sf::st_read("https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?service=wfs&version=2.0.0&request=getFeature&typenames=cbsgebiedsindelingen:cbs_gemeente_2019_gegeneraliseerd&outputFormat=json")

  df <- get_data("housing_data")

  test <- as_tibble(test)
  test <- left_join(df, test, by = c("municip_code" = "statcode")) %>%
    filter(year == 2019)
  test <- st_sf(as.data.frame(test, stringsAsFactors = FALSE))

  plotly::plot_ly(test, split = ~municip_code, color = ~`housing stock`)
}
