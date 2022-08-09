library(shiny)

dados <- readr::read_rds(here::here("dados/pkmn.rds"))

ui <- navbarPage(
  title = "Pokemon",
  tabPanel(
    title = "Grama",
    conteudo_ui("conteudo_grama", dados, "grama")
  ),
  tabPanel(
    title = "Água",
    conteudo_ui("conteudo_agua", dados, "água")
  ),
  tabPanel(
    title = "Fogo",
    conteudo_ui("conteudo_fogo", dados, "fogo")
  ),
  tabPanel(
    title = "Pedra",
    conteudo_ui("conteudo_pedra", dados, "pedra")
  )
)

server <- function(input, output, session) {

  conteudo_server("conteudo_grama", dados, "grama")

  conteudo_server("conteudo_agua", dados, "água")

  conteudo_server("conteudo_fogo", dados, "fogo")

  conteudo_server("conteudo_pedra", dados, "pedra")

}

shinyApp(ui, server)
