#' Main Server
#'
#' This function returns the main server function for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
#' @noRd
main_server <- function(housing_data, housing_price, filtered_migration, mapdata, woon) {
  function(input, output, session) {
    dropdown_box_graph_server(
      "housing_stock",
      "year",
      "housing stock",
      housing_data,
      "municipality",
      line_graph_server)
    
    dropdown_box_graph_server(
      "housing_price",
      "year",
      "Average selling price",
      housing_price,
      "municipality",
      line_graph_server)
    
    stock_map_server(
      "housing_stock_map",
      mapdata,
      housing_data)

    dropdown_box_graph_server(
      "satisfaction1",
      "tevrstr",
      "leeftijd",
      woon,
      "coropchar",
      barplot_server)

    barplot_server(
      "satisfaction2",
      "tevrstr",
      "corop",
      woon)

    dropdown_box_graph_server(
      "move_desire1",
      "verhwens",
      "leeftijd",
      woon,
      "coropchar",
      barplot_server)

    barplot_server(
      "move_desire2",
      "verhwens",
      "corop",
      woon)

    dropdown_box_graph_server(
      "vacancy1",
      "verleegst",
      "leeftijd",
      woon,
      "coropchar",
      barplot_server)

    barplot_server(
      "vacancy2",
      "verleegst",
      "corop",
      woon)

    price_map_server(
      "housing_price_map",
      mapdata,
      housing_price)
    
    migration_map_server(
      "migration_map",
      mapdata,
      filtered_migration)
    
    dropdown_box_graph_server(
      "barplot_migration1",
      "Percentage",
      "municipality",
      filtered_migration,
      "province",
      barplot_migration_server)
    
    barplot_migration_server(
      "barplot_migration2",
      filtered_migration,
      "Percentage",
      "municipality")
  }
}
