## code to prepare `geo_estados` dataset goes here

geo_estados <- readr::read_rds("data-raw/geo_estados.rds")

usethis::use_data(geo_estados, overwrite = TRUE)
