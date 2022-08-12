library(shiny)

rm_acento <- function(x) {
  stringi::stri_trans_general(x, "Latin-ASCII")
}

dados <- readr::read_rds(here::here("dados/pkmn.rds"))

ui <- navbarPage(
  title = "Pokemon",
  id = "menu"
)

server <- function(input, output, session) {

  purrr::walk(
    unique(dados$tipo_1),
    ~ appendTab(
      inputId = "menu",
      tab = tabPanel(
        title = stringr::str_to_title(.x),
        conteudo_ui(rm_acento(.x), dados, .x)
      ),
      select = ifelse(.x == "grama", TRUE, FALSE)
    )
  )

  purrr::walk(
    unique(dados$tipo_1),
    ~ conteudo_server(rm_acento(.x), dados, .x)
  )

}

shinyApp(ui, server)
