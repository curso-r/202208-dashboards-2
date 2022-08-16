#' filtro UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_filtro_ui <- function(id, fazer_filtro_estado = FALSE) {
  ns <- NS(id)
  tagList(
    fluidRow(
      bs4Dash::bs4Card(
        title = "Filtros",
        width = 12,
        fluidRow(
          column(
            width = 4,
            selectInput(
              inputId = ns("ano"),
              label = "Selecione o ano",
              choices = unique(sort(pnud$ano))
            )
          ),
          if (fazer_filtro_estado) {
            column(
              width = 4,
              selectInput(
                inputId = ns("uf"),
                label = "Selecione o estado",
                choices = unique(sort(pnud$uf_sigla))
              )
            )
          },
          column(
            width = 4,
            selectInput(
              inputId = ns("metrica"),
              label = "Selecione a métrica",
              choices = c("idhm", "espvida", "rdpc", "gini")
            )
          )
        )
      )
    )
  )
}

#' filtro Server Functions
#'
#' @noRd
mod_filtro_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    valores_do_filtro <- reactive({
      list(ano = input$ano, metrica = input$metrica, uf = input$uf)
    })

    return(valores_do_filtro)

  })
}









