seleciona <- function(tab, coluna) {
  tab |>
    dplyr::select({{coluna}})
}
