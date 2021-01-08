input <- tibble::tribble(
  ~Gemeentecode, ~GemeentecodeGM, ~Gemeentenaam,
  ~Provinciecode, ~ProvinciecodePV, ~Provincienaam,
  ~stock_date, ~imputed_stock, ~imputed_price, ~imputed_population,
  1337, "GM1337", "Kakariko", 12, "PV12", "Eldin",
  lubridate::ymd(20200213), "150", "203400", "342")
res <- clean_imputed_data(input)

test_that("GemeentecodeGM is renamed municip_code", {
  expect_equal(
    dplyr::pull(res, .data$municip_code),
    dplyr::pull(input, .data$GemeentecodeGM))
})

test_that("Gemeentenaam is renamed municipality", {
  expect_equal(
    dplyr::pull(res, .data$municipality),
    dplyr::pull(input, .data$Gemeentenaam))
})

test_that("Provincienaam is renamed province", {
  expect_equal(
    dplyr::pull(res, .data$province),
    dplyr::pull(input, .data$Provincienaam))
})

test_that("Result's year is same as stock_date's year", {
  expect_equal(
    dplyr::pull(res, .data$year),
    lubridate::year(dplyr::pull(input, .data$stock_date)))
})

test_that("`housing stock`, `Average selling price` and population are numeric", {
  expect_true(all(is.numeric(pull(res, .data$`housing stock`))))
  expect_true(all(is.numeric(pull(res, .data$`Average selling price`))))
  expect_true(all(is.numeric(pull(res, .data$population))))
})

test_that("imputed_stock is renamed `housing stock`", {
  expect_equal(
    as.character(dplyr::pull(res, .data$`housing stock`)),
    dplyr::pull(input, .data$imputed_stock))
})

test_that("imputed_price is renamed `Average selling price`", {
  expect_equal(
    as.character(dplyr::pull(res, .data$`Average selling price`)),
    dplyr::pull(input, .data$imputed_price))
})

test_that("imputed_population is renamed population", {
  expect_equal(
    as.character(dplyr::pull(res, .data$population)),
    dplyr::pull(input, .data$imputed_population))
})
