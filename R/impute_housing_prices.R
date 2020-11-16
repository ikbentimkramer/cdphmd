price_fraction <- function(municip_old, municip_new) {
  municip_old[,"housing price"] *
  (municip_old[,"housing stock"] / municip_new[["housing stock"]])
}

many2one_impute <- function(df) {
  res <- list()
  res["housing stock"] <- sum(df[,"housing stock"])
  price_fractions <- price_fraction(df, res)
  res["housing_price"] <- sum(price_fractions)
  res[["housing_price"]]
}
