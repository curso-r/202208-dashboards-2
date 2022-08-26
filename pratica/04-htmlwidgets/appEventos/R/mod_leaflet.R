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
    h1("Leaflet"),
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
              choices = c(1991, 2000, 2010),
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
        leaflet::leafletOutput(ns("mapa"))
      ),
      column(
        width = 6,
        reactable::reactableOutput(ns("tabela"))
      )
    )
  )
}

#' leaflet Server Functions
#'
#' @noRd
mod_leaflet_server <- function(id, tbl_pnud) {
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$mapa <- leaflet::renderLeaflet({
      input_ano <- input$ano
      input_metrica <- input$metrica
      tab_mapa <- tbl_pnud |>
        dplyr::filter(ano == input_ano) |>
        dplyr::group_by(uf_sigla) |>
        dplyr::summarise(
          media = mean(.data[[input_metrica]], na.rm = TRUE)
        ) |>
        dplyr::collect() |>
        dplyr::left_join(
          geo_estados,
          by = c("uf_sigla" = "abbrev_state")
        ) |>
        sf::st_as_sf()

      cores <- leaflet::colorNumeric(
        palette = rev(viridis::plasma(8)),
        domain = tab_mapa$media
      )

      tab_mapa |>
        leaflet::leaflet() |>
        leaflet::addTiles() |>
        leaflet::addPolygons(
          layerId = ~uf_sigla,
          fillColor = ~cores(media),
          color = "black",
          fillOpacity = 0.8,
          weight = 1,
          label  = ~name_state
        ) |>
        leaflet::addLegend(
          pal = cores,
          values = ~media,
          opacity = 0.7,
          title = NULL,
          position = "bottomright"
        )
    })

    output$tabela <- reactable::renderReactable({

      estado <- input$mapa_shape_click$id
      input_ano <- input$ano
      input_metrica <- input$metrica

      if (is.null(estado)) {
        estado <- "RJ"
      }

      tbl_pnud |>
        dplyr::filter(uf_sigla == estado, ano == input_ano) |>
        dplyr::arrange(dplyr::desc(.data[[input_metrica]])) |>
        head(n = 10) |>
        dplyr::select(muni_nm, one_of(input_metrica), espvida, idhm, rdpc, gini) |>
        dplyr::collect() |>
        reactable::reactable()

    })

  })
}

