# Módulo dispersão --------------------------------------------------------

dispersao_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 4,
        selectInput(
          ns("variavel_x"),
          label = "Selecione a variável X",
          choices = names(mtcars)
        )
      ),
      column(
        width = 4,
        selectInput(
          ns("variavel_y"),
          label = "Selecione a variável Y",
          choices = names(mtcars)
        )
      )
    ),
    br(),
    plotOutput(ns("grafico_2"))
  )

}

dispersao_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$grafico_2 <- renderPlot({
      plot(
        x = mtcars[[input$variavel_x]],
        y = mtcars[[input$variavel_y]]
      )
    })

  })
}
