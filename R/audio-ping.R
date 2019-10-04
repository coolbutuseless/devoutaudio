

clamp <- function(x, min=0, max=1) {
  pmax(pmin(x, max), min)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Generate a ping
#'
#' @param lr_fraction 0 = left only, 1 = right only, 0.5 = same level in each
#'        channel
#' @param y_fraction from 0 = lowest note, to 1 = highest note
#' @param duration duration in seconds. Note: this is currenlty clamped arbitrarily
#'        to be between 1/20 and 3
#'
#' @import audio
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
play_ping <- function(lr_fraction, y_fraction, duration = 1/5) {

  duration <- clamp(duration, 1/20, 3)
  lr_fraction <- clamp(lr_fraction)
  freq <- 200 + clamp(y_fraction) * 12000

  mat <- rbind(
    x = sin(seq(freq * duration)) * (1-lr_fraction),
    y = sin(seq(freq * duration)) * lr_fraction
  )

  x <- audio::audioSample(mat, freq)
  play(x)
}

