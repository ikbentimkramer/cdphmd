#' Read migration data
#'
#' This function retrieves migration data for 2015 and 2019 of the
#' municipalities of Drenthe, Friesland and Groningen
#' @importFrom jsonlite read_json
#' @noRd
read_migration_data <- function() {
  jsonlite::read_json(paste0(
    "https://opendata.cbs.nl/ODataApi/OData/37259eng/TypedDataSet/",
    "?$filter=(substringof('GM',Regions)) and ", # Filter statement
    "((Periods eq '2015JJ00') or ",
    "(Periods eq '2019JJ00')) and ",
    "&$select=Periods,Regions,PopulationOn1January_1"), # Column select
    simplifyDataFrame = TRUE)[["value"]]
}
