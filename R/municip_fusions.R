clean_municip_fusions <- function(df, year = as.double(NA)) {
  df %>%
    dplyr::filter(
      stringr::str_detect(
        added_to_created_municip_province,
        "(Gr|F|D)")) %>%
    dplyr::select(
      removed_from_removed_municip,
      added_to_created_municip,
      inhabitants) %>%
    dplyr::rename(
      from_raw = removed_from_removed_municip,
      to_raw = added_to_created_municip) %>%
    dplyr::filter(!is.na(from_raw) & !is.na(to_raw)) %>%
    dplyr::mutate(
      from = paste0("GM", stringr::str_extract(from_raw, "^[0-9]{4}")),
      to = paste0("GM", stringr::str_extract(to_raw, "^[0-9]{4}")),
      year = year) %>%
    dplyr::select(
      year,
      from,
      to,
      inhabitants)
}

municip_fusions <- function() {
  shared_cols <- c(
    "removed_from_existing_municip",
    "removed_from_existing_municip_province",
    "removed_from_removed_municip",
    "removed_from_removed_municip_province",
    "added_to_existing_municip",
    "added_to_existing_municip_province",
    "added_to_created_municip",
    "added_to_created_municip_province")
  dplyr::bind_rows(
    readxl::read_excel(
      paste0(
        "grenswijzigingen-tussen-resp-opheffing-samenvoeging-en-nieuwvorming-",
        "van-gemeenten-1-januari-2019.xlsx"),
      range = "A11:K70",
      col_names = c(
        shared_cols,
        "inhabitants",
        "houses",
        "area_in_km2"
      )) %>%
      clean_municip_fusions(2019),
    readxl::read_excel(
      paste0(
        "grenswijzigingen-samenvoeging-en-nieuwvorming-van-",
        "gemeenten.xlsx"),
      range = "A7:K39",
      col_names = c(
        shared_cols,
        "should_be_missing",
        "inhabitants",
        "area_in_km2"
      )) %>%
      clean_municip_fusions(2018),
    readxl::read_excel(
      "Gemeentelijke wijzigingen per 1 januari 2017.xlsx",
      range = "A7:J14",
      col_names = c(
        shared_cols,
        "inhabitants",
        "area_in_km2"
      )) %>%
      clean_municip_fusions(2017),
    readxl::read_excel(
      "Gemeentelijke wijzigingen per 1 januari 2016.xlsx",
      range = "A9:J27",
      col_names = c(
        shared_cols,
        "inhabitants",
        "area_in_km2"
      )) %>%
      clean_municip_fusions(2016))
}
