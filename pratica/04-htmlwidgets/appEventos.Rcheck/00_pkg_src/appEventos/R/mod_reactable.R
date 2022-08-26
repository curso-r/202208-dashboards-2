#' reactable UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_reactable_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("Reactable"),
    hr(),
    fluidRow(
      bs4Dash::bs4Card(
        title = "Filtros",
        width = 12,
        fluidRow(
          column(
            width = 4,
            selectInput(
              ns("ano"),
              label = "Selecione um ano",
              choices = unique(pnud$ano),
              width = "90%"
            )
          ),
          column(
            width = 4,
            selectInput(
              ns("metrica"),
              label = "Selecione uma métrica",
              choices = c(
                "IDHM" = "idhm",
                "Expectativa de vida" = "espvida",
                "Renda per capita" = "rdpc",
                "Índice de GINI" = "gini"
              ),
              width = "90%"
            )
          )
        )
      )
    ),
    br(),
    fluidRow(
      column(
        width = 6,
        reactable::reactableOutput(ns("tabela"))
      ),
      column(
        width = 6,
        leaflet::leafletOutput(ns("mapa"))
      )
    )
  )
}

#' reactable Server Functions
#'
#' @noRd
mod_reactable_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    pnud_top10 <- reactive({
      pnud |>
        dplyr::filter(
          ano == input$ano
        ) |>
        dplyr::arrange(dplyr::desc(.data[[input$metrica]])) |>
        dplyr::slice(1:10)
    })

    output$tabela <- reactable::renderReactable({
      pnud_top10() |>
        dplyr::select(muni_nm, one_of(input$metrica), espvida, idhm, rdpc, gini) |>
        reactable::reactable(
          selection = "multiple",
          defaultSelected = 1
        )
    })

    output$mapa <- leaflet::renderLeaflet({
      linhas_selecionadas <- reactable::getReactableState("tabela", "selected")

      if (is.null(linhas_selecionadas)) {
        NULL
      } else {
        pnud_top10() |>
          dplyr::slice(linhas_selecionadas) |>
          leaflet::leaflet() |>
          leaflet::addTiles() |>
          leaflet::addAwesomeMarkers(
            lng = ~ lon,
            lat = ~ lat,
            label = ~ muni_nm
          )
      }

    })

  })
}
