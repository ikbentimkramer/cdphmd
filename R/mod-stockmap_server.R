#' Server for housing data map
#'
#' @param id Shiny id
#' @param mapdata A sf object of municipalities in the Netherlands
#' @param housing_data A tibble with municipality codes and housing stock data
#' @return A shiny module server
#'
#' @importFrom tibble as_tibble
#' @importFrom htmltools HTML
#' @importFrom sf st_sf st_transform
#' @noRd
stock_map_server <- function(id, mapdata, housing_data) {
  test <- mapdata

  df <- housing_data

  test <- tibble::as_tibble(test)
  test <- dplyr::left_join(df, test, by = c("municip_code" = "statcode")) %>%
    dplyr::filter(.data$year == 2019)
  test <- sf::st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- sf::st_transform(test, crs = 4326)

  bins <- c(0, 15000, 30000, 45000, 60000, 75000, 90000, 105000, 120000)


  labels <- sprintf(
    "<strong>%s</strong><br/>%g houses",
    test$municipality, test$`housing stock`
  ) %>% lapply(htmltools::HTML)

  pal <- leaflet::colorBin(palette = "viridis", reverse = TRUE, domain = test$`housing stock`, bins = bins)

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
