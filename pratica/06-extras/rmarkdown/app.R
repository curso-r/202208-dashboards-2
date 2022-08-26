library(shiny)

dados <- readr::read_rds("pkmn.rds")

ui <- fluidPage(
  style = "margin-bottom: 200px;",
  theme = bslib::bs_theme(version = 4),
  h1("Relatórios em R Markdown dentro do Shiny"),
  hr(),
  h3("Sobre este app"),
  fluidRow(
    column(
      width = 6,
      includeMarkdown("sobre_o_app.md")
    ),
    column(
      width = 6,
      includeMarkdown("sobre_o_app.md")
    )
  ),
  hr(),
  fluidRow(
    class = "align-items-center",
    column(
      width = 4,
      offset = 3,
      selectInput(
        "pokemon",
        label = "Selecione um pokemon",
        choices = unique(dados$pokemon)
      )
    ),
    column(
      width = 2,
      downloadButton("gerar_relatorio", "Gerar relatório")
    )
  )
)

server <- function(input, output, session) {


  output$gerar_relatorio <- downloadHandler(
    filename = "relatorio.pdf",
    content = function(file) {

      arquivo_html <- tempfile(
        fileext = ".html"
      )

      cor <- dados$cor_1[dados$pokemon == input$pokemon]

      withProgress(message = "Renderizando o html", {

        incProgress(0.2)

        rmarkdown::render(
          input = "template_relatorio.Rmd",
          output_file = arquivo_html,
          params = list(pokemon = input$pokemon, cor = cor)
        )

        incProgress(0.5, message = "Renderizando o PDF...")

        pagedown::chrome_print(
          input = arquivo_html,
          output = file
        )

        incProgress(0.3)

      })



    }
  )

}

shinyApp(ui, server)



