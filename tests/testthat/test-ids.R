context("test identifiers")

test_that("identifier conversion works", {
  expect_equal(anyid2shortid('nm20120726c3'), '120726c3')
  expect_equal(anyid2longid("120726BJK1742SF274LC.lsm"), 'nm20120726c3')
  expect_equal(anyid2stack("120726c3"), '120726B')
})
