#' Server for migration map
#'
#' @param id Shiny id
#' @param mapdata A sf object of municipalities in the Netherlands
#' @param filtered_migration A dataset with municipality codes, names and population balance from 2015 to 2019
#' @return A shiny module server
#'
#' @importFrom tibble as_tibble
#' @importFrom htmltools HTML
#' @importFrom sf st_sf st_transform
#' @noRd
migration_map_server <- function(id, mapdata, filtered_migration) {
  test <- mapdata
  
  df <- filtered_migration
  
  test <- tibble::as_tibble(test)
  test <- dplyr::left_join(df, test, by = c("municip_code" = "statcode"))
  test <- sf::st_sf(as.data.frame(test, stringsAsFactors = FALSE))
  test <- sf::st_transform(test, crs = 4326)
  
  bins <- c(-1500, -1000, -500,0,500,1500,5000,10000)
  
  
  labels <- sprintf(
    "<strong>%s</strong><br/>%g citizens",
    test$municipality, test$Balance
  ) %>% lapply(htmltools::HTML)
  
  pal <- leaflet::colorBin(palette = "viridis", domain = test$Balance, bins = bins)
  
  shiny::moduleServer(id, function(input, output, session) {
    output$migrationmap  <- leaflet::renderLeaflet({
      leaflet::leaflet(test) %>%
        leaflet::addPolygons(
          fillColor = ~pal(Balance),
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
        ) %>% leaflet::addLegend(pal = pal, values = ~Balance, opacity = 0.7, title = "Population change",
                                 position = "bottomright")
    })
  })
}
