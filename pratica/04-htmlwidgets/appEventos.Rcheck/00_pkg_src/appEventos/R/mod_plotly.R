#' plotly UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plotly_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("plotly"),
    hr(),
    bs4Dash::bs4Card(
      title = "Filtro",
      width = 12,
      selectInput(
        ns("ano"),
        label = "Selecione um ano",
        choices = sort(unique(pnud$ano)),
        width = "25%"
      )
    ),
    fluidRow(
      column(
        width = 8,
        plotly::plotlyOutput(ns("grafico"))
      ),
      column(
        width = 4,
        reactable::reactableOutput(ns("tabela"))
      )
    )

  )
}

#' plotly Server Functions
#'
#' @noRd
mod_plotly_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    pnud_filtrada <- reactive({
      pnud |>
        dplyr::filter(ano == input$ano)
    })

    output$grafico <- plotly::renderPlotly({
      p <- pnud_filtrada() |>
        ggplot2::ggplot(ggplot2::aes(x = rdpc, y = espvida)) +
        ggplot2::geom_point()

      plotly::ggplotly(p)
    })

    output$tabela <- reactable::renderReactable({

      ponto_selecionado <- plotly::event_data("plotly_click")

      if (is.null(ponto_selecionado)) {
        NULL
      } else {
        pnud_filtrada() |>
          dplyr::slice(ponto_selecionado$pointNumber + 1) |>
          dplyr::select(muni_nm, rdpc, espvida, idhm, gini) |>
          dplyr::mutate(
            dplyr::across(
              .fns = as.character
            )
          ) |>
          tidyr::pivot_longer(
            cols = dplyr::everything(),
            names_to = "var",
            values_to = "val"
          ) |>
          reactable::reactable(
            columns = list(
              var = reactable::colDef(
                name = ""
              ),
              val = reactable::colDef(
                name = ""
              )
            )
          )
      }


    })



  })
}

