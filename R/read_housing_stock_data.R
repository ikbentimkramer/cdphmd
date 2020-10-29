#' Read housing stock data
#'
#' This function retrieves housing stock counts for 2015-2019 of the
#' north of the Netherlands.
#' @import jsonlite
#' @noRd
read_housing_stock_data <- function() {
  jsonlite::read_json(paste0(
    "https://opendata.cbs.nl/ODataApi/OData/81955ENG/TypedDataSet/",
    "?$filter=(substringof('LD01',Regions)) and ", # Filter statement
    "((Periods eq '2015JJ00') or ",
    "(Periods eq '2016JJ00') or ",
    "(Periods eq '2017JJ00') or ",
    "(Periods eq '2018JJ00') or ",
    "(Periods eq '2019JJ00')) and ",
    "(Purpose eq 'T001419')",
    "&$select=Periods,Regions,InitialStock_1"), # Column select
    simplifyDataFrame = TRUE)
}
