#' Read housing price data
#'
#' This function retrieves average selling price of existing owner-occupied
#' homes for 2015-2019 in the municipalities of the Netherlands
#' @importFrom jsonlite read_json
#' @noRd
read_housing_price_data <- function() {
  jsonlite::read_json(paste0(
   "https://opendata.cbs.nl/ODataApi/odata/83625NED/TypedDataSet",
    "?$filter=(substringof('GM',RegioS)) and ", # Filter statement
    "((Perioden eq '2015JJ00') or ",
    "(Perioden eq '2016JJ00') or ",
    "(Perioden eq '2017JJ00') or ",
    "(Perioden eq '2018JJ00') or ",
    "(Perioden eq '2019JJ00')) and ",
   
    "&$select=Perioden,RegioS,GemiddeldeVerkoopprijs_1"), # Column select
    simplifyDataFrame = TRUE)[["value"]]
}
