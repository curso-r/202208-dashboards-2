#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic

  con <- RSQLite::dbConnect(RSQLite::SQLite(), "pnud_min.sqlite")
  tbl_pnud <- dplyr::tbl(con, "pnud")

  mod_reactable_server("reactable_ui_1", tbl_pnud)
  mod_leaflet_server("leaflet_ui_1", tbl_pnud)
  mod_plotly_server("plotly_ui_1")
  mod_echarts_server("echarts_ui_1")
  mod_tippy_server("tippy_ui_1")

}
