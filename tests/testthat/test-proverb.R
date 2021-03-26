context("Checking data cleaning")

t <- proverb(22, as_string = TRUE)

test_that("Returned proverb is okay", {

  expect_equal(t, paste0("Ask your doctor if right is left for you.\n",
                         "    -- \"A Memory of Europe\", 15 April 2013"))

})
