price_map_ui <- function (id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    leaflet::leafletOutput(ns("prmap"))
  )
}