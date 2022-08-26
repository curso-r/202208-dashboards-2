library(shiny)
library(dplyr)

ui <- fluidPage(
  h1("Editando banco de dados"),
  hr(),
  DT::dataTableOutput("tabela"),
  br(),
  actionButton("salvar", "Salvar alterações")
)


server <- function(input, output, session) {

  tabela_para_salvar <- reactiveVal(NULL)

  con <- RSQLite::dbConnect(
    RSQLite::SQLite(),
    "mtcars.sqlite"
  )

  output$tabela <- DT::renderDataTable({
    tab_mtcars <- tbl(con, "mtcars") |>
      collect()

    tabela_para_salvar(tab_mtcars)

    tab_mtcars |>
      DT::datatable(
        editable = TRUE
      )
  })

  proxy <- DT::dataTableProxy("tabela")

  observeEvent(input$tabela_cell_edit, {

    tab_atual <- tabela_para_salvar()

    tab_atualizada <- DT::editData(
      tab_atual,
      input$tabela_cell_edit
    )

    DT::replaceData(
      proxy,
      tab_atualizada
    )

    tabela_para_salvar(tab_atualizada)

  })

  observeEvent(input$salvar, {
    RSQLite::dbWriteTable(
      con,
      "mtcars",
      tabela_para_salvar(),
      overwrite = TRUE
    )

    showModal(
      modalDialog(
        "Alterações salvas com sucesso!",
        title = "Aviso",
        easyClose = TRUE,
        footer = modalButton("Fechar")
      )
    )
  })


}

shinyApp(ui, server)
