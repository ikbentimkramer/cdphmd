test_map_f <- function(df) {
  test <- sf::st_read("https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?service=wfs&version=2.0.0&request=getFeature&typenames=cbsgebiedsindelingen:cbs_gemeente_2019_gegeneraliseerd&outputFormat=json")
  
  df <- get_data("housing_data")
  
  test <- as_tibble(test)
  test <- left_join(df, test, by = c("municip_code" = "statcode")) %>%
    filter(year == 2019)
  test <- st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- st_transform(test, "+init=epsg:4326")
  
  bins <- c(5000, 10000, 15000, 20000, 25000, 35000, 60000, 130000)
  
  
  labels <- sprintf(
    "<strong>%s</strong><br/>%g houses",
    test$municipality, test$`housing stock`
  ) %>% lapply(htmltools::HTML)
  
  pal <- colorBin(palette = "Blues", domain = test$`housing stock`, bins = bins)
  
  
  map1 <- leaflet(test) %>%
    addPolygons(
      fillColor = ~pal(`housing stock`),
      weight = 2,
      opacity = 1,
      color = "white",
      dashArray = "3",
      fillOpacity = 5,
      highlight = highlightOptions(
        weight = 3,
        color = "#666",
        dashArray = "",
        fillOpacity = 10,
        bringToFront = TRUE),
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
    addLegend(pal = pal, values = ~`housing stock`, opacity = 0.7, title = "Housing stock",
              position = "bottomright")
  map1
}