#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic
  mod_reactable_server("reactable_ui_1")
  mod_plotly_server("plotly_ui_1")
  mod_leaflet_server("leaflet_ui_1")
}
