test_that("correctly reads municipality codes and respective names", {
  data <- read_municipality()
  expect_identical(colnames(data), c("Gemeentecode", "GemeentecodeGM",
                                     "Gemeentenaam", "Provinciecode", "ProvinciecodePV",
                                     "Provincienaam"))
  expect_identical(data$Gemeentenaam[which(data$GemeentecodeGM == "GM1684")], "Cuijk")
})
