nossa_e_tooltip <- function (e, trigger = c("item", "axis"),
          ...)
{
  if (missing(e)) {
    stop("must pass e", call. = FALSE)
  }
  tooltip <- list(trigger = trigger[1], ...)
  if (!e$x$tl) {
    e$x$opts$tooltip <- tooltip
  }
  else {
    e$x$opts$baseOption$tooltip <- tooltip
  }
  e
}
