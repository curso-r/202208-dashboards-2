## code to prepare `dados` dataset goes here

dados <- readr::read_rds("data-raw/rick_and_morty.rds")

usethis::use_data(dados, overwrite = TRUE)
