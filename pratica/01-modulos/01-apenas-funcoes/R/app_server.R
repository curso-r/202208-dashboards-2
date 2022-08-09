app_server <- function(imdb) {
  function(input, output, session) {

    imdb_filtrada <- reactive({
      imdb |>
        dplyr::filter(stringr::str_detect(generos, input$genero))
    })

    output$grafico1 <- renderPlot({
      imdb_filtrada() |>
        ggplot(aes(x = ano)) +
        geom_bar()
    })

    output$grafico2 <- renderPlot({
      imdb_filtrada() |>
        dplyr::group_by(ano) |>
        dplyr::summarise(receita_media = mean(receita, na.rm = TRUE)) |>
        ggplot(aes(x = ano, y = receita_media)) +
        geom_col()
    })


  }
}
