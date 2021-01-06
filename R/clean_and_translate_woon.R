#' Clean and Translate Woon Survey Data
#'
#' Removes superfluous columns and translates labels to English.
#'
#' @param woonpath path to woon survey data
#'
#' @return a dataframe with labelled vectors
#'
#' @importFrom dplyr select
#' @importFrom labelled set_variable_labels set_value_labels
#' @noRd
clean_and_translate_woon <- function(woonpath = "") {
  get_data("woon", woonpath = woonpath) %>%
    dplyr::select(
      ldl,
      corop,
      leeftijd,
      tevrstr,
      verhwens,
      verleegst,
      coropchar) %>%
    labelled::set_variable_labels(
      leeftijd = "Age respondent (7 groups)",
      tevrstr = "How satisfied are you with the region where you are living?",
      verleegst = "How has the vacancy rate of homes in your area changed in the past 5 years?",
      verhwens = "Do you want to move within 2 years?") %>%
    labelled::set_value_labels(
      leeftijd = c(
        `17-24 years old` = 1,
        `25-34 years old` = 2,
        `35-44 years old` = 3,
        `45-54 years old` = 4,
        `55-64 years old` = 5,
        `65-74 years old` = 6,
        `75 and over` = 7),
      tevrstr = c(
        `Very satisfied` = 1,
        `Satisfied` = 2,
        `Not satisfied, but also not unsatisfied` = 3,
        `Unsatisfied` = 4,
        `Very unsatisfied` = 5,
        `Refuses to answer` = 8),
      verhwens = c(
        `Definitely not` = 1,
        `Possibly yes, maybe` = 2,
        `Would like to, can't find anything` = 3,
        `Definitely yes` = 4,
        `I have already found another accommodation / home` = 5,
        `Refuses` = 8),
      verleegst = c(
        `Has become much more` = 1,
        `Has become more` = 2,
        `Stayed the same` = 3,
        `Has become less` = 4,
        `Has become much less` = 5,
        `Do not know` = 6,
        `Refuses` = 8))
}
