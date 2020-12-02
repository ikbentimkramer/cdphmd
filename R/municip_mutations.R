#' Retrieve and Clean Municipality Mutations Data
#'
#' This function retrieves all mutations, fusions, and namechanges of
#' municipalities in the Netherlands from January 1st 1995 onwards.
#'
#' @return A tibble::tibble() that has the columns:
#'   \describe{
#'     \item{date}{The date of the mutation}
#'     \item{from}{The municipality code where land, inhabitants and/or houses were taken from}
#'     \item{to}{The municipality code where land, inhabitants and/or houses were moved to}
#'     \item{hectares}{The area transferred in hectares}
#'     \item{inhabitants}{The number of inhabitants transferred}
#'     \item{houses}{The number of houses transferred}
#'     \item{name_change}{True if the mutation records a name change. For name changes no transfer amounts were recorded.}
#'   }
#' @import dplyr
#' @import tidyr
#' @import stringr
#' @import tibble
#' @importFrom lubridate dmy
#' @importFrom jsonlite read_json
#' @importFrom rlang .data
#' @noRd
municip_mutations <- function() {
  df <- read_raw_municip_mutations()
  df <- tibble::as_tibble(df) %>%
    ## Remove unneccesary column
    dplyr::select(-.data$CategoryGroupID) %>%
    ## Select municipalities only
    dplyr::filter(stringr::str_detect(.data$Key, "^GM")) %>%
    ## Extract mutations
    dplyr::mutate(
      mutations = mutations_lexer(.data$Description)) %>%
    dplyr::mutate(
      mutations = lapply(.data$mutations, .data$mutations_parser)) %>%
    ## Unfold mutations into single data frame
    rename(account = .data$Key) %>%
    dplyr::select(.data$account, .data$mutations) %>%
    tidyr::unnest(.data$mutations) %>%
    dplyr::mutate(
      from = if_else(.data$recieved, .data$municip_code, .data$account),
      to = if_else(.data$recieved, .data$account, .data$municip_code)) %>%
    dplyr::select(
      .data$date,
      .data$from,
      .data$to,
      .data$hectares,
      .data$inhabitants,
      .data$houses,
      .data$name_change) %>%
    dplyr::distinct() %>%
    dplyr::arrange(dplyr::desc(.data$date))
}

read_raw_municip_mutations <- function() {
  jsonlite::read_json(
    "https://opendata.cbs.nl/ODataApi/OData/70072ned/RegioS",
    simplifyDataFrame = TRUE)[["value"]]
}

mutations_lexer <- function(desc) {
  rules <- tibble::tribble(
    ~rule,                           ~token,
    "[0-9]{2}-[0-9]{2}-[0-9]{4}",    "date",
    "[0-9]+\\s+\\w+",                "number_label",
    "GM[0-9]{4}",                    "municip_code",
    "ontvangen| uit:|oude naam:",    "recieved",
    "overgegaan|nieuwe naam:",       "lost")
  regex_str <- rules %>%
    dplyr::pull(.data$rule) %>%
    paste0("(", .data, ")", collapse = "|")
  res <- stringr::str_match_all(desc, regex_str)
  res <- lapply(res, function(x) {
    colnames(x) <- rules %>%
      dplyr::pull(.data$token) %>%
      c("match", .data)
    x <- tibble::as_tibble(x, rownames = "order") %>%
      dplyr::mutate(order = as.integer(.data$order)) %>%
      tidyr::gather("token", "value", -.data$order, -.data$match) %>%
      dplyr::filter(!is.na(.data$value)) %>%
      dplyr::select(-.data$match) %>%
      dplyr::arrange(.data$order)
  })
  res
}

mutations_parser <- function(tokendf){
  tokendf <- tibble::as_tibble(tokendf)
  if((tokendf %>% nrow()) <= 1) {
    return(tibble::tibble())
  }
  ## Create grouping variables
  date_counter <- 0
  municip_counter <- 0
  date_group <- c()
  municip_group <- c()
  for(token in dplyr::pull(tokendf, .data$token)) {
    if(token == "date"){
      date_counter <- date_counter + 1
      municip_counter <- 0
    }
    if(token == "municip_code"){
      municip_counter <- municip_counter + 1
    }
    date_group <- append(date_group, date_counter)
    municip_group <- append(municip_group, municip_counter)
  }
  res <- tokendf %>%
    dplyr::mutate(dategroup = date_group) %>%
    dplyr::mutate(municipgroup = municip_group)

  ## Extract date and recieved columns
  res <- dplyr::left_join(
    res,
    res  %>%
      dplyr::group_by(.data$dategroup) %>%
      dplyr::filter(
        .data$token == "date" |
          .data$token == "recieved" |
          .data$token == "lost") %>%
      dplyr::mutate(
        name_change = if_else(
          any(
            .data$token == "recieved" &
              .data$value == "oude naam:" |
              .data$token == "lost" &
              .data$value == "nieuwe naam:"),
          TRUE,
          FALSE),
        value = if_else(.data$token == "recieved", "TRUE", .data$value),
        value = if_else(.data$token == "lost", "FALSE", .data$value),
        token = if_else(.data$token == "lost", "recieved", .data$token),
        date = NA,
        recieved = NA) %>%
      dplyr::select(-.data$order, -.data$municipgroup) %>%
      tidyr::spread(.data$token, .data$value) %>%
      dplyr::mutate(
        date = lubridate::dmy(.data$date),
        recieved = as.logical(.data$recieved)),
    by = "dategroup")

  ## Parse number_label to inwoners, woningen and hectare label/values
  res <- dplyr::left_join(
    res,
    res %>%
      dplyr::filter(.data$token == "number_label") %>%
      tidyr::separate(.data$value, c("value", "token"), sep = " ") %>%
      dplyr::select(.data$order, .data$value, .data$token),
    by = "order",
    suffix = c("", ".new")) %>%
    dplyr::mutate(
      token = if_else(
        is.na(.data$token.new),
        .data$token,
        .data$token.new),
      value = if_else(is.na(.data$value.new),
        .data$value,
        .data$value.new)) %>%
    dplyr::select(-.data$value.new, -.data$token.new)

  ## Extract municip_code, inhabitants, houses, and hectares
  res <- dplyr::left_join(
    res,
    res %>%
      dplyr::filter(.data$municipgroup > 0) %>%
      dplyr::group_by(.data$dategroup, .data$municipgroup) %>%
      dplyr::select(-.data$order) %>%
      dplyr::mutate(
        municip_code = NA,
        inwoners = NA,
        hectare = NA,
        woningen = NA) %>%
      tidyr::spread(.data$token, .data$value) %>%
      dplyr::mutate(
        hectares = as.integer(.data$hectare),
        inhabitants = as.integer(.data$inwoners),
        houses = as.integer(.data$woningen)) %>%
      dplyr::select(
        .data$dategroup,
        .data$municipgroup,
        .data$municip_code,
        .data$hectares,
        .data$inhabitants,
        .data$houses),
    by = c("dategroup", "municipgroup"))

  ## Remove superfluous rows/columns
  res <- res %>%
    dplyr::select(-.data$order, -.data$token, -.data$value) %>%
    dplyr::filter(.data$municipgroup > 0) %>%
    dplyr::distinct() %>%
    dplyr::select(-.data$dategroup, -.data$municipgroup)
  res
}
