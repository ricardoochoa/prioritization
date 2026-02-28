test_that("s_standardize scales correctly with 'observe' method", {
  # Empirical tests
  res1 <- s_standardize(c(0, 50, 100))
  expect_equal(res1, c(0, 50, 100))

  res2 <- s_standardize(c(-100, 0, 100))
  expect_equal(res2, c(0, 50, 100))

  res3 <- s_standardize(c(10, 20, 30))
  expect_equal(res3, c(0, 50, 100))
})

test_that("s_standardize scales correctly with 'benchmark' method", {
  res1 <- s_standardize(
    c(0, 50, 100, 200),
    selected_method = "benchmark",
    min_bound = 0,
    max_bound = 100
  )
  expect_equal(res1, c(0, 50, 100, 100)) # Caps at 100

  res2 <- s_standardize(
    c(-50, 50, 150),
    selected_method = "benchmark",
    min_bound = 0,
    max_bound = 100
  )
  expect_equal(res2, c(0, 50, 100)) # Bounds at 0 and 100
})

test_that("s_standardize handles edge cases and errors", {
  # Error when method is invalid
  expect_error(
    s_standardize(c(1, 2, 3), selected_method = "foo"),
    "`selected_method` must be either 'observe' or 'benchmark'."
  )

  # Error when benchmark method is used but min_bound/max_bound is missing
  expect_error(
    s_standardize(c(1, 2, 3), selected_method = "benchmark"),
    paste(
      "`min_bound` and `max_bound` parameters must be provided",
      "when `selected_method` is 'benchmark'."
    )
  )

  # Warning when max equals min
  expect_warning(
    res <- s_standardize(
      c(5, 5, 5),
      selected_method = "benchmark",
      min_bound = 10,
      max_bound = 10
    ),
    "MIN and MAX are equal; returning a vector of zeros."
  )
  expect_equal(res, c(0, 0, 0))
})
