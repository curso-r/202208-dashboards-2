app_ui <- function(imdb) {
  opcoes <- imdb |>
    dplyr::pull(generos) |>
    stringr::str_split(", ") |>
    unlist() |>
    unique() |>
    sort()

  tagList(
    h1("IMDB"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "genero",
          label = "Selecione um gênero",
          choices = opcoes
        )
      ),
      mainPanel(
        plotOutput("grafico1"),
        plotOutput("grafico2")
      )
    )
  )
}

app_ui2 <- function(imdb) {
  opcoes <- imdb |>
    dplyr::pull(generos) |>
    stringr::str_split(", ") |>
    unlist() |>
    unique() |>
    sort()

  tagList(
    h1("IMDB"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "genero",
          label = "Selecione um gênero",
          choices = opcoes
        )
      ),
      mainPanel(
        plotOutput("grafico3"),
        plotOutput("grafico4")
      )
    )
  )
}
