stock_map_server <- function(id) {
  test <- get_data("municip_map")

  df <- get_data("housing_data")

  test <- tibble::as_tibble(test)
  test <- dplyr::left_join(df, test, by = c("municip_code" = "statcode")) %>%
    filter(year == 2019)
  test <- sf::st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- sf::st_transform(test, "+init=epsg:4326")

  bins <- c(5000, 10000, 15000, 20000, 25000, 35000, 60000, 130000)


  labels <- sprintf(
    "<strong>%s</strong><br/>%g houses",
    test$municipality, test$`housing stock`
  ) %>% lapply(htmltools::HTML)

  pal <- leaflet::colorBin(palette = "Blues", domain = test$`housing stock`, bins = bins)

  shiny::moduleServer(id, function(input, output, session) {
    output$stmap  <- leaflet::renderLeaflet({
      leaflet::leaflet(test) %>%
        leaflet::addPolygons(
          fillColor = ~pal(`housing stock`),
          weight = 2,
          opacity = 1,
          color = "white",
          dashArray = "3",
          fillOpacity = 5,
          highlight = leaflet::highlightOptions(
            weight = 5,
            color = "#666",
            dashArray = "",
            fillOpacity = 10,
            bringToFront = TRUE
          ),
          label = labels,
          labelOptions = leaflet::labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
              textsize = "15px",
              direction = "auto"
            )
          ) %>% leaflet::addLegend(pal = pal, values = ~`housing stock`, opacity = 0.7, title = "Housing stock",
                position = "bottomright")
      }
    )
  })
}
