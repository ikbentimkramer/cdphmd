#' Municipality codes and names
#'
#' Reads the identification data for municipalities
#'
#' @return a dataframe with every municipality code,name and province
#' @import readxl
#' @importFrom utils download.file
#' @export
#'
#' @examples
#' df = read_municipality()
read_municipality <- function(){
  url = "https://www.cbs.nl/-/media/_excel/2020/03/gemeenten-alfabetisch-2020.xlsx"
  temp.file <- paste0(tempfile(),".xlsx")
  utils::download.file(url, temp.file, mode = "wb")
  tmp <- readxl::read_excel(temp.file)
}
