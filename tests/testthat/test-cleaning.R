context("Checking data cleaning")

df <- get_proverb_dataset()

test_that("Returned dataset is okay", {
  skip_if_offline()

  expect_equal(ncol(df), 5)

  expect_equal(df$title[1], "Pilot")
  expect_equal(df$title[194], "The Fog")


})
