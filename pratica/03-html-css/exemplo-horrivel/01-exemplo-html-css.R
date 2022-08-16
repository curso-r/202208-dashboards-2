library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      "h1 {
        color: orange;
      }

      h2 {
        color: purple;
      }
      "
    ),
    tags$link(rel = "stylesheet", href = "custom.css")
  ),
  h1("Título do meu app", align = "center", class = "inversa"),
  tags$h2("Subtitulo do app"),
  br(),
  a(
    href = "https://curso-r.com",
    "Este é o link para o site da curso-r.",
    target = "_blank",
    class = "inversa"
  ),
  br(),
  fluidRow(
    column(
      width = 2,
      offset = 5,
      img(src = "logo.png", width = "100%", alt = "O logo da empresa curso-r."),
    )
  ),
  p("agjagã gaçjga~çg lagçkj agç~kja gajg ~poaejg apgo jap gjag "),
  img(src = "logo.png", width = 100, alt = "O logo da empresa curso-r.", id = "imagem1"),
  p("Imagem 1: essa é a legenda dessa imagem.", style = "text-align: center;"),
  img(src = "logo.png", width = 100, alt = "O logo da empresa curso-r."),
  p("Oi", class = "paragrafo"),
  p("Oi", class = "inversa"),
  div("Oi, div!"),
  span("Oi"),
  span("Oi"),
  hr(),
  p("com algum texto", style = "color: red; font-size: 20pt;"),
  div(
    id = "divVazia",
    p("Um texto qualquer", style = "position: relative; left: 100px; top: 100px;")
  ),
  p("com mais texto"),
  p("Esse elemento vai ser fixo", style = "position: fixed; color: black; top: 100px;"),
  HTML("<a href = ''>link</a>"),
  div(
    style = "height: 300px; background-color: yellow; position: relative;",
    div(style = "height: 20px;"),
    div(
      style = "height: 100px; background-color: pink; "
    ),
    div(
      style = "height: 100px; background-color: orange;",
      p("Mais um texto qualquer.", style = "position: absolute; top: 10px;")
    )
  ),
  br(),
  br()

)

server <- function(input, output, session) {

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
