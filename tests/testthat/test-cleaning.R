context("Checking data cleaning")

df <- get_proverb_dataset()

df <-

test_that("multiplication works", {
  skip_if_offline()

  expect_equal(ncol(df), 7)

  expect_equal(df$title[1], "Pilot")
  expect_equal(df$title[194], "The Fog")


})
