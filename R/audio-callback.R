

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# None of the following device calls actually do anything yet.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
audio_open     <- function(args, state) { state }
audio_close    <- function(args, state) { state }
audio_line     <- function(args, state) { state }
audio_rect     <- function(args, state) { state }
audio_polyline <- function(args, state) { state }
audio_polygon  <- function(args, state) { state }
audio_path     <- function(args, state) { state }
audio_text     <- function(args, state) { state }


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Map a circle to a single ping
#   - x maps to stereo position
#   - y maps to frequency of ping
#   - size maps to duration of ping
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
audio_circle <- function(args, state) {

  # Fraction across and up from the origin of the plot (lower-left corner)
  lr_fraction <- args$x/state$dd$right
  y_fraction  <- 1 - args$y/state$dd$bottom

  # Duration of tone is dependent upon size. Bigger size -> bigger duration
  duration <- args$r/5 * 1/5

  play_ping(lr_fraction, y_fraction, duration)

  # Need to give the audio device time to play the pings
  Sys.sleep(duration)

  state
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Audio callback for the rdevice
#'
#' @param device_call name of device function call
#' @param args arguments to device function call
#' @param state list of rdata, dd and gc. Some or all of which may be NULL
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
audio_callback <- function(device_call, args, state) {

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Anything we're not handling, just return() straight away
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # print(state$name)
  state <- switch(
    device_call,
    "open"         = audio_open      (args, state),
    "close"        = audio_close     (args, state),
    "line"         = audio_line      (args, state),
    "polyline"     = audio_polyline  (args, state),
    "circle"       = audio_circle    (args, state),
    "rect"         = audio_rect      (args, state),
    "text"         = audio_text      (args, state),
    "textUTF8"     = audio_text      (args, state),
    'polygon'      = audio_polygon   (args, state),
    'path'         = audio_path      (args, state),
    'circle'       = audio_circle    (args, state),
    state
  )

  state
}


if (FALSE) {

  library(devout)
  library(ggplot2)
  library(dplyr)

  plot_df <- mtcars %>%
    arrange(mpg)

  audio()
  ggplot(plot_df) +
    geom_point(aes(mpg, wt, size = cyl)) +
    theme(legend.position = 'none')
  dev.off()


  audio()
  plot(1:10)
  dev.off()

  audio()
  plot(mtcars$mpg, mtcars$wt)
  dev.off()
}















