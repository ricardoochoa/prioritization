test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("s_config produces correct output structure and defaults", {
  df <- data.frame(a = c(1, 2, 3), b = c(10, 20, 30))

  res <- s_config(df)

  expect_s3_class(res, "data.frame")
  expect_equal(nrow(res), 2)
  expect_equal(res$id, c("a", "b"))
  expect_equal(res$name, c("a", "b"))
  expect_equal(res$group, c("general", "general"))
  expect_equal(res$weight, c(1, 1))
  expect_equal(res$direction, c("smaller is better", "smaller is better"))
  expect_equal(res$method, c("observe", "observe"))
  expect_equal(res$min, c(1, 10))
  expect_equal(res$max, c(3, 30))
})

test_that("s_config handles custom parameters", {
  df <- data.frame(a = c(1, 2, 3), b = c(10, 20, 30))
  res <- s_config(
    df,
    name = c("VarA", "VarB"),
    group = c("g1", "g2"),
    weight = c(2, 0.5),
    direction = c("larger is better", "smaller is better"),
    method = c("benchmark", "observe"),
    min = c(0, 0),
    max = c(5, 50)
  )

  expect_equal(res$name, c("VarA", "VarB"))
  expect_equal(res$group, c("g1", "g2"))
  expect_equal(res$weight, c(2, 0.5))
  expect_equal(res$direction, c("larger is better", "smaller is better"))
  expect_equal(res$method, c("benchmark", "observe"))
  expect_equal(res$min, c(0, 0))
  expect_equal(res$max, c(5, 50))
})

test_that("s_config fails with invalid input", {
  expect_error(s_config(c(1, 2, 3)), "Input 'x' must be a data frame or a matrix.")
})
