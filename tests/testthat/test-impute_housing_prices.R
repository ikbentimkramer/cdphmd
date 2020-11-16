input <- data.frame(matrix(nrow = 4))
input[,"housing stock"] <- c(100, 200, 300, 400)
input[,"housing price"] <- c(400, 300, 200, 100)

test_that("price fractions get calculated correctly", {
  total <- list()
  total["housing stock"] <- sum(input[,"housing stock"])
  expected <- c(40, 60, 60, 40)
  expect_equal(price_fraction(input, total), expected)
})

test_that("many2one_impute works", {
  expect_equal(many2one_impute(input), 200)
})
