test_that("correctly reads municipality codes and respective names", {
  temp <- mockery::mock("municipality_codes_test")
  dontdownload <- mockery::mock()
  mockery::stub(read_municipality, "utils::download.file", dontdownload)
  mockery::stub(read_municipality, "tempfile", temp, depth = 2)
  data <- read_municipality()
  expect_identical(colnames(data), c("Gemeentecode", "GemeentecodeGM",
                                     "Gemeentenaam", "Provinciecode", "ProvinciecodePV",
                                     "Provincienaam"))
  expect_identical(data$Gemeentenaam[which(data$GemeentecodeGM == "GM1684")], "Cuijk")
})
