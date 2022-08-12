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
    mod_filtro_ui(ns("filtro_ui_1")),
    fluidRow(
      column(
        width = 12,
        reactable::reactableOutput(ns("tabela_rt"))
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

    valores_do_filtro <- mod_filtro_server("filtro_ui_1")

    output$tabela_rt <- reactable::renderReactable({

      pnud |>
        dplyr::filter(ano == valores_do_filtro()$ano) |>
        dplyr::arrange(dplyr::across(valores_do_filtro()$metrica, dplyr::desc)) |>
        dplyr::slice(1:10) |>
        dplyr::select(
          muni_nm,
          uf_sigla,
          valores_do_filtro()$metrica,
          idhm,
          espvida,
          rdpc,
          gini
        ) |>
        reactable::reactable(
          striped = TRUE,
          searchable = TRUE,
          filterable = TRUE,
          bordered = TRUE,
          highlight = TRUE,
          # defaultPageSize = 5,
          theme = reactable::reactableTheme(
            stripedColor = "grey"
          ),
          defaultColDef = reactable::colDef(
            align = "right"
          ),
          columns = list(
            muni_nm = reactable::colDef(
              align = "center"
            )
          )
        )
    })

  })
}

## To be copied in the UI
# mod_reactable_ui("reactable_ui_1")

## To be copied in the server
# mod_reactable_server("reactable_ui_1")
