con <- RSQLite::dbConnect(
  RSQLite::SQLite(),
  "pratica/05-reatividade/editando-banco-de-dados/mtcars.sqlite"
)

RSQLite::dbWriteTable(con, "mtcars", mtcars)

RSQLite::dbDisconnect(con)
