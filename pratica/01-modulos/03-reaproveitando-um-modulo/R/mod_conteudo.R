conteudo_ui <- function(id, dados, tipo) {
  ns <- NS(id)
  opcoes <- dados |>
    dplyr::filter(tipo_1 == tipo) |>
    dplyr::pull(pokemon) |>
    unique()
  tagList(
    fluidRow(
      column(
        width = 4,
        selectInput(
          ns("pokemon"),
          label = "Selecione um pokemon",
          choices = opcoes
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        uiOutput(ns("imagem"))
      ),
      column(
        width = 6,
        plotOutput(ns("grafico"))
      )
    )
  )
}

conteudo_server <- function(id, dados, tipo) {
  moduleServer(id, function(input, output, session) {


    output$imagem <- renderUI({

      id <- dados |>
        dplyr::filter(pokemon == input$pokemon) |>
        dplyr::pull(id) |>
        stringr::str_pad(width = 3, sid = "left", pad = "0")

      url <- glue::glue(
        "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/{id}.png"
      )

      img(src = url, width = "50%")

    })

    output$grafico <- renderPlot({

      dados |>
        dplyr::filter(tipo_1 == tipo) |>
        tidyr::pivot_longer(
          cols = c(hp, ataque, defesa, ataque_especial, defesa_especial, velocidade),
          names_to = "variavel",
          values_to = "valor"
        ) |>
        ggplot2::ggplot(ggplot2::aes(x = valor, y = variavel, fill = variavel)) +
        ggridges::geom_density_ridges(show.legend = FALSE)

    })



  })
}
