#' Get path for files within this package
#'
#' @param path relative path to file in this package
#' @return the absolute path to the file
#' @noRd
this_pkg <- function(path) {
  system.file(path ,package="cdphmd")
}
