library(shiny)

ui <- navbarPage(
  title = "Módulos",
  tabPanel(
    title = "Histograma",
    histograma_ui("histograma")
  ),
  tabPanel(
    title = "Dispersão",
    dispersao_ui("dispersao")
  )
)

server <- function(input, output, session) {
  histograma_server("histograma")
  dispersao_server("dispersao")
}

shinyApp(ui, server)
