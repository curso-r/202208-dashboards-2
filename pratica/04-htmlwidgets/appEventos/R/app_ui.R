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
    bs4Dash::bs4DashPage(
      bs4Dash::bs4DashNavbar(title = "HTMLWIDGETS"),
      bs4Dash::bs4DashSidebar(
        bs4Dash::bs4SidebarMenu(
          bs4Dash::bs4SidebarMenuItem(
            "reactable",
            tabName  = "reactable",
            icon = icon("table")
          ),
          bs4Dash::bs4SidebarMenuItem(
            "leaflet",
            tabName  = "leaflet",
            icon = icon("map")
          ),
          bs4Dash::bs4SidebarMenuItem(
            "plotly",
            tabName  = "plotly",
            icon = icon("line-chart")
          ),
          bs4Dash::bs4SidebarMenuItem(
            "echarts",
            tabName  = "echarts",
            icon = icon("bar-chart")
          ),
          bs4Dash::bs4SidebarMenuItem(
            "tippy",
            tabName  = "tippy",
            icon = icon("letter")
          )
        )
      ),
      bs4Dash::bs4DashBody(
        bs4Dash::bs4TabItems(
          bs4Dash::bs4TabItem(
            tabName = "reactable",
            mod_reactable_ui("reactable_ui_1")
          ),
          bs4Dash::bs4TabItem(
            tabName = "leaflet",
            mod_leaflet_ui("leaflet_ui_1")
          ),
          bs4Dash::bs4TabItem(
            tabName = "plotly",
            mod_plotly_ui("plotly_ui_1")
          ),
          bs4Dash::bs4TabItem(
            tabName = "echarts",
            mod_echarts_ui("echarts_ui_1")
          ),
          bs4Dash::bs4TabItem(
            tabName = "tippy",
            mod_tippy_ui("tippy_ui_1")
          )
        ),
        tags$script(
          src = "https://unpkg.com/@popperjs/core@2"
        ),
        tags$script(
          src = "https://unpkg.com/tippy.js@6"
        ),
        tags$script(
          src = "www/tooltip.js"
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
    # bundle_resources(
    #   path = app_sys('app/www'),
    #   app_title = 'appEventos'
    # )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

