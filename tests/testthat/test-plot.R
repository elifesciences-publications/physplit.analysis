context("test-plot.R")

test_that("plotting cell traces", {
  commodor <- c("OilBl", "MetSl", "HexAc", "PeEtA", "AceAc", "EtHex", "2PnAc",
                "5OdMx", "E2Hex", "GerAc", "Prpyl", "IPenA", "Et3HB", "Nonnl",
                "CiVAc", "BeZal", "bCitr", "1HxOl", "Frnsl", "WatBl", "Cdvrn",
                "Sprmn", "Acoin", "MtAct", "AcAcd", "PrpnA", "BtrAc", "Amnia",
                "Pyrdn", "PAcHd", "HCL36", "PAcAc", "Vingr", "Geosn", "VinGe",
                "PEtAm", "FlyFM", "EtAmn", "Sprdn", "Ptscn", "Lnlol", "23BTD",
                "CO21P")
  owd <- setwd(tempdir())
  on.exit(setwd(owd))
  expect_warning(plotcellsf("nm20140205c0", xaxis=TRUE,odours = commodor))
})
