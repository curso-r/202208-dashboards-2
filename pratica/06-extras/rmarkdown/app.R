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

    }
  )

}

shinyApp(ui, server)



