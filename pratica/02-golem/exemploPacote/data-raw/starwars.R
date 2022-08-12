## code to prepare `starwars` dataset goes here

starwars <- dplyr::starwars |>
  dplyr::select(-mass, -height)

usethis::use_data(starwars, overwrite = TRUE)
