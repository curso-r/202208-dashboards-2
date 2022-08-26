#' tippy UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_tippy_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("tippy"),
    hr(),
    fluidRow(
      bs4Dash::bs4Card(
        title = "Filtros",
        width = 12,
        fluidRow(
          column(
            width = 3,
            div(
              id = "filtro_ano",
              selectInput(
                ns("ano"),
                label = "Selecione um ano",
                choices = sort(unique(pnud$ano))
              )
            )
          ),
          column(
            width = 3,
            div(
              id = "filtro_regiao",
              selectInput(
                ns("regiao"),
                label = "Selecione uma região",
                choices = sort(unique(pnud$regiao_nm))
              )
            )
          ),
          column(
            width = 3,
            selectInput(
              ns("uf"),
              label = "Selecione um estado",
              choices = c("Carregando..." = "")
            )
          ),
          column(
            width = 3,
            selectInput(
              ns("muni"),
              label = "Selecione um município",
              choices = c("Carregando..." = "")
            )
          )
        ),
        fluidRow(
          column(
            width = 2,
            offset = 5,
            actionButton(ns("pesquisar"), "Pesquisar"),
          )
        )
      )
    ),
    br(),
    reactable::reactableOutput(ns("tabela"))

  )
}

#' tippy Server Functions
#'
#' @noRd
mod_tippy_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observe({
      ufs <- pnud |>
        dplyr::filter(regiao_nm == input$regiao) |>
        dplyr::pull(uf_sigla)

      updateSelectInput(
        inputId = "uf",
        choices = ufs
      )
    })

    observe({
      munis <- pnud |>
        dplyr::filter(uf_sigla == input$uf) |>
        dplyr::select(muni_nm, muni_id) |>
        tibble::deframe()

      updateSelectInput(
        inputId = "muni",
        choices = munis
      )

    })

    pnud_filtrada <- eventReactive(input$pesquisar, {
      pnud |>
        dplyr::filter(
          ano == input$ano,
          muni_id == input$muni
        )
    })

    output$tabela <- reactable::renderReactable({

      pnud_filtrada() |>
        dplyr::select(
          Município = muni_nm,
          População = pop,
          IDHM = idhm,
          `Esp. Vida` = espvida,
          `Renda per capita` = rdpc,
          GINI = gini
        ) |>
        reactable::reactable()

    })

  })
}

