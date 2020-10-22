#' Main Server
#'
#' This function returns the main server function for this dashboard.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(main_ui(), main_server())
#' }
#' @import shiny
main_server <- function() {
    function(input, output, session) {
        output$hello  <- shiny::renderText("Hello, world!")
    }
}
