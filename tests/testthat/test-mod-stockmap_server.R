poly1 <- sf::st_polygon(list(rbind(c(0,1), c(0,0), c(1,0), c(1,1), c(0,1))))
poly2 <- sf::st_polygon(list(rbind(c(1,1), c(1,0), c(2,0), c(2,1), c(1,1))))
map <- tibble::tribble(
  ~statcode, ~geometry,
  "GM0021", poly1,
  "GM1337", poly2)
map  <- sf::st_sf(as.data.frame(map))
map <- sf::st_set_crs(map, 4326)
data <- tibble::tribble(
  ~municip_code, ~municipality, ~year, ~`housing stock`,
  "GM0021", "Anorien", 2018, 10000,
  "GM0021", "Anorien", 2019, 10020,
  "GM1337", "Ithilien", 2019, 20010)

test_that("Map server does not throw errors", {
  shiny::testServer(
    args = list(mapdata = map, housing_data = data),
    stock_map_server,
    {
      expect_error(output$stmap, NA)
    })
})
