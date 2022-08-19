#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic

  output$grafico <- echarts4r::renderEcharts4r({

    dados |>
      dplyr::filter(num_temporada == input$temporada) |>
      dplyr::mutate(
        titulo = paste(num_dentro_temporada, titulo, sep = " - ")
      ) |>
      dplyr::arrange(dplyr::desc(num_dentro_temporada)) |>
      echarts4r::e_chart(x = qtd_espectadores_EUA, reorder = FALSE) |>
      echarts4r::e_bar(serie = titulo) |>
      echarts4r::e_y_axis(
        type = "category",
        axisLabel = list(color = "white")
      ) |>
      echarts4r::e_x_axis(
        name = "Número de expectadores nos EUA (em milhões)",
        nameLocation = "center",
        nameGap = 30,
        nameTextStyle = list(color = "white", fontSize = 16),
        axisLabel = list(color = "white")
      ) |>
      echarts4r::e_legend(show = FALSE) |>
      echarts4r::e_grid(containLabel = TRUE) |>
      echarts4r::e_color(color = "#08acc6")

  })

}
