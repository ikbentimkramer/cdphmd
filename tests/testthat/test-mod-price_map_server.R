poly1 <- sf::st_polygon(list(rbind(c(0,1), c(0,0), c(1,0), c(1,1), c(0,1))))
poly2 <- sf::st_polygon(list(rbind(c(1,1), c(1,0), c(2,0), c(2,1), c(1,1))))
map <- tibble::tribble(
  ~statcode, ~geometry,
  "GM0059", poly1,
  "GM0106", poly2)
map  <- sf::st_sf(as.data.frame(map))
map <- sf::st_set_crs(map, 4326)
data <- tibble::tribble(
  ~municip_code, ~municipality, ~year, ~`Average selling price`,
  "GM0059", "Achtkarspelen", 2018, 211426,
  "GM0059", "Achtkarspelen", 2019, 216483,
  "GM0106", "Assen", 2019, 228658)

test_that("Map server does not throw errors", {
  shiny::testServer(
    args = list(mapdata = map, housing_price = data),
    price_map_server,
    {
      expect_error(output$prmap, NA)
    })
})
