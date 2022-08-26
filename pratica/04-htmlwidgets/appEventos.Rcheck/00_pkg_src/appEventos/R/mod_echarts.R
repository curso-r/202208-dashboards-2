#' echarts UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_echarts_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("echarts"),
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
    echarts4r::echarts4rOutput(ns("grafico"))
  )
}

#' echarts Server Functions
#'
#' @noRd
mod_echarts_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$grafico <- echarts4r::renderEcharts4r({

      tooltip <- htmlwidgets::JS(
        glue::glue(
          "function (params) {
            console.log(params);
            tx = params.name + '<br>' + params.marker + '<b>{{input$metrica}}</b>: ' + parseFloat(params.value[1]).toFixed(2);
            return(tx);
          }",
        .open = "{{",
        .close = "}}"
        )
      )

      pnud |>
        dplyr::filter(ano == input$ano) |>
        dplyr::group_by(uf_sigla) |>
        dplyr::summarise(
          media = mean(.data[[input$metrica]])
        ) |>
        dplyr::arrange(dplyr::desc(media)) |>
        echarts4r::e_chart(x = uf_sigla) |>
        echarts4r::e_bar(serie = media) |>
        echarts4r::e_legend(show = FALSE) |>
        nossa_e_tooltip(
          trigger = "item",
          # formatter = glue::glue(
          #   "{b}<br>[input$metrica]: {c}",
          #   .open = "[",
          #   .close = "]"
          # )
          formatter = tooltip,
          borderColor = "purple",
          backgroundColor = "yellow"
        ) |>
        echarts4r::e_color(color = "purple")

    })

  })
}

