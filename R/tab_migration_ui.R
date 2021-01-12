#' UI for migration tab
#'
#' @return snippet for the migration tab in the main UI
#' @noRd
tab_migration_ui <- function() {
  shinydashboard::tabItem(
    "migration",
    shiny::includeMarkdown(this_pkg("www/md/migration.md")),
    shiny::fluidRow(
      shinydashboard::box(
        migration_map_ui(
          "migration_map"))),
    shiny::fluidRow(
      shinydashboard::box(width = 12,
                          shiny::includeMarkdown(this_pkg("www/md/migration2.md")))))
}
