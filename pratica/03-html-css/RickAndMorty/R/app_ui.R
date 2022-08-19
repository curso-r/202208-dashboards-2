#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("Rick and Morty", align = "center"),
      hr(),
      fluidRow(
        column(
          width = 3,
          selectInput(
            "temporada",
            label = "Selecione a temporada",
            choices = sort(unique(dados$num_temporada))
          )
        )
      ),
      fluidRow(
        column(
          width = 2,
          img(src = "www/rick.png", class = "rick_and_morty")
        ),
        column(
          width = 10,
          class = "areaGrafico",
          echarts4r::echarts4rOutput("grafico", height = "600px")
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'RickAndMorty'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

