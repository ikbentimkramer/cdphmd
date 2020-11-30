df = read.csv("gemeenten.csv")
mapdata <- sf::st_as_sf(df, wkt = "geom")
mapdata2 <- sf::st_cast(mapdata, "MULTIPOLYGON")

x = get_data("housing_data")
#names(x)[1] <- "gemeentenaam"

df_map <- dplyr::right_join(x, mapdata2, by = by = c("Gemeentenaam", "gemeentenaam"))
df_map <- sf::st_as_sf(df_map, wkt = "geom")
df_map2 <- sf::st_cast(df_map, "MULTIPOLYGON")


fig <- plotly::plot_ly(data,
               split = ~gemeentenaam,
               showlegend = FALSE
               )
fig

data = rjson::fromJSON(file = "https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?service=wfs&version=2.0.0&request=getFeature&typenames=cbsgebiedsindelingen:cbs_gemeente_2019_gegeneraliseerd&outputFormat=json")
#data <- as.data.frame(data)
data1 <- sf::st_as_sf(data, wkt = "geom")
data2 <- sf::st_cast(data1, "MULTIPOLYGON")