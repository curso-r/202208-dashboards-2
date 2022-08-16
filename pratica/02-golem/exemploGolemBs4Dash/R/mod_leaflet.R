#' leaflet UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_leaflet_ui <- function(id){
  ns <- NS(id)
  tagList(
    mod_filtro_ui(ns("filtro_ui_1"), fazer_filtro_estado = TRUE),
    fluidRow(
      column(
        width = 10,
        offset = 1,
        leaflet::leafletOutput(ns("mapa_leaflet"))
      )
    )
  )
}

#' leaflet Server Functions
#'
#' @noRd
mod_leaflet_server <- function(id) {
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    valores_do_filtro <- mod_filtro_server("filtro_ui_1")

    output$mapa_leaflet <- leaflet::renderLeaflet({

      pnud |>
        dplyr::filter(
          ano == valores_do_filtro()$ano,
          uf_sigla == valores_do_filtro()$uf
        ) |>
        dplyr::arrange(dplyr::across(
          valores_do_filtro()$metrica, dplyr::desc
        )) |>
        dplyr::slice(1:10) |>
        leaflet::leaflet() |>
        leaflet::addTiles() |>
        leaflet::addMarkers(
          lng = ~lon,
          lat = ~lat,
          label = ~muni_nm,
          popup = ~muni_nm
        )

    })

  })
}

## To be copied in the UI
# mod_leaflet_ui("leaflet_ui_1")

## To be copied in the server
# mod_leaflet_server("leaflet_ui_1")
