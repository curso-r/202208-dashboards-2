#' plotly UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plotly_ui <- function(id) {
  ns <- NS(id)
  tagList(
    mod_filtro_ui(ns("filtro_ui_1")),
    fluidRow(
      column(
        width = 6,
        plotly::plotlyOutput(ns("grafico_plotly"))
      ),
      column(
        width = 6,
        plotly::plotlyOutput(ns("grafico_plotly2"))
      )
    )
  )
}

#' plotly Server Functions
#'
#' @noRd
mod_plotly_server <- function(id){
  moduleServer( id, function(input, output, session) {
    ns <- session$ns

    valores_do_filtro <- mod_filtro_server("filtro_ui_1")

    output$grafico_plotly <- plotly::renderPlotly({

      p <- pnud |>
        dplyr::filter(ano == valores_do_filtro()$ano) |>
        dplyr::rename(x = valores_do_filtro()$metrica) |>
        ggplot2::ggplot(ggplot2::aes(x = x, y = espvida)) +
        ggplot2::geom_point() +
        ggplot2::theme_minimal()

      plotly::ggplotly(p)

    })

    output$grafico_plotly2 <- plotly::renderPlotly({

      pnud |>
        dplyr::filter(ano == valores_do_filtro()$ano) |>
        dplyr::rename(x = valores_do_filtro()$metrica) |>
        plotly::plot_ly(
          x = ~x,
          y = ~espvida,
          type = "scatter"
        )

    })

  })
}

## To be copied in the UI
# mod_plotly_ui("plotly_ui_1")

## To be copied in the server
# mod_plotly_server("plotly_ui_1")
