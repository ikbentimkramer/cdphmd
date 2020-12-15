#' Server for housing price map
#'
#' @param id Shiny id
#' @param mapdata A sf object of municipalities in the Netherlands
#' @param housing_data A tibble with municipality codes and average housing price data
#' @return A shiny module server
#'
#' @importFrom tibble as_tibble
#' @importFrom htmltools HTML
#' @importFrom sf st_sf st_transform
#' @noRd
price_map_server <- function(id, mapdata, housing_price) {
  test <- mapdata
  
  df <- housing_price
  
  test <- tibble::as_tibble(test)
  test <- dplyr::left_join(df, test, by = c("municip_code" = "statcode")) %>%
    dplyr::filter(.data$year == 2019)
  test <- sf::st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- sf::st_transform(test, "+init=epsg:4326")
  
  bins <- c(140000, 180000, 220000, 260000, 300000, 350000, 400000, 450000)
  
  
  labels <- sprintf(
    "<strong>%s</strong><br/>%g euros",
    test$municipality, test$`Average selling price`
  ) %>% lapply(htmltools::HTML)
  
  pal <- leaflet::colorBin(palette = "viridis", domain = test$`Average selling price`, bins = bins)
  
  shiny::moduleServer(id, function(input, output, session) {
    output$prmap  <- leaflet::renderLeaflet({
      leaflet::leaflet(test) %>%
        leaflet::addPolygons(
          fillColor = ~pal(`Average selling price`),
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
        ) %>% leaflet::addLegend(pal = pal, values = ~`Average selling price`, opacity = 0.7, title = "Average selling price",
                                 position = "bottomright")
    }
    )
  })
}
