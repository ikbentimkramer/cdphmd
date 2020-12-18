test_map_migration <- function(df) {
  test <- sf::st_read("https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?service=wfs&version=2.0.0&request=getFeature&typenames=cbsgebiedsindelingen:cbs_gemeente_2019_gegeneraliseerd&outputFormat=json")
  
  df <- clean_migration_data(read_migration_data(), read_municipality())
  
  test <- as_tibble(test)
  test <- left_join(df, test, by = c("municipality" = "statnaam"))
  test <- sf::st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- sf::st_transform(test, "+init=epsg:4326")
  
  bins <- c(-1000, -500, 0, 500, 1500, 5000, 15000, 31000)
  
  
  labels <- sprintf(
    "<strong>%s</strong><br/>%g people",
    test$municipality, test$`Balance`
  ) %>% lapply(htmltools::HTML)
  
  pal <- leaflet::colorBin(palette = "Blues", domain = test$`Balance`, bins = bins)
  
  
  map1 <- leaflet::leaflet(test) %>%
    leaflet::addPolygons(
      fillColor = ~pal(`Balance`),
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
    leaflet::addLegend(pal = pal, values = ~`Balance`, opacity = 0.7, title = "Population change",
              position = "bottomright")
  map1
} 