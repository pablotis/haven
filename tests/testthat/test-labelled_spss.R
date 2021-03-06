context("labelled_spss")

test_that("constructor checks na_value", {
  expect_incompatible_type(labelled_spss(1:10, na_values = "a"))
})

test_that("constructor checks na_range", {
  expect_error(labelled_spss(1:10, na_range = "a"), "must be a numeric vector")
  expect_error(labelled_spss(1:10, na_range = 1:3), "of length two")
  expect_error(
    labelled_spss("a", c(a = "a"), na_range = 1:2),
    "only applicable for labelled numeric"
  )
})

test_that("printed output is stable", {
  x <- labelled_spss(
    1:5, c("Good" = 1, "Bad" = 5),
    na_values = c(1, 2),
    na_range = c(3, Inf)
  )
  expect_output_file(print(x), "labelled-spss-output.txt")
})

test_that("subsetting preserves attributes", {
  x <- labelled_spss(
    1:5, c("Good" = 1, "Bad" = 5),
    na_values = c(1, 2),
    na_range = c(3, Inf),
    label = "Rating"
  )
  expect_identical(x, x[])
})

test_that("labels must be unique", {
  expect_error(
    labelled_spss(1, c(female = 1, male = 1), na_values = 9),
    "must be unique")
})

# is.na -------------------------------------------------------------------

test_that("values in na_range flagged as missing", {
  x <- labelled_spss(1:5, c("a" = 1), na_range = c(1, 3))
  expect_equal(is.na(x), c(TRUE, TRUE, TRUE, FALSE, FALSE))
})

test_that("values in na_values flagged as missing", {
  x <- labelled_spss(1:5, c("a" = 1), na_values = c(1, 3, 5))
  expect_equal(is.na(x), c(TRUE, FALSE, TRUE, FALSE, TRUE))
})


# Types -------------------------------------------------------------------

test_that("combining preserves class", {
  skip("todo")
  expect_s3_class(vec_c(labelled_spss(), labelled_spss()), "haven_labelled_spss")
})
