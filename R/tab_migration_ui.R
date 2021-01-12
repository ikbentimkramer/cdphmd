#' UI for migration tab
#'
#' @return snippet for the migration tab in the main UI
#' @noRd
tab_migration_ui <- function(filtered_migration) {
  shinydashboard::tabItem(
    "migration",
    shiny::includeMarkdown(this_pkg("www/md/migration.md")),
    shiny::fluidRow(
      shinydashboard::box(
        migration_map_ui(
          "migration_map")),
      shinydashboard::box(
        title = "Population percentage change per province",
        dropdown_box_graph_ui(
          "barplotmigration1",
          barplot_migration_ui,
          "province",
          unique(filtered_migration[,"province"])))))}
   