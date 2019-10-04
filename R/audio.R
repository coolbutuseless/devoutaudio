


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' "Graphics" device for audio output
#'
#' Graphics primitives will be rendered to audio.
#'
#' Uses \code{devout::rdevice()}.
#'
#' @param ... other parameters passed to the rdevice
#'
#' @import devout
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
audio <- function(...) {
  devout::rdevice('audio_callback', ...)
}
