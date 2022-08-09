library(shiny)
library(ggplot2)

imdb <- readr::read_rds(here::here("dados/imdb.rds"))

ui <- fluidPage(
  app_ui(imdb),
  app_ui2(imdb),
  "Mais coisas aqui em baixo"
)

server <- app_server(imdb)

shinyApp(ui, server)
