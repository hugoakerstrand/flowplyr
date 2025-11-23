# Use GvHD dataset which comes with flowCore
data(GvHD, package = "flowCore")
test_flowset <- GvHD[1:3]  # Use first 3 samples for faster tests

# Input Validation Tests -------------------------------------------------------

test_that("to_tibble errors with non-flowSet input", {
  expect_error(
    to_tibble(data.frame(x = 1:5)),
    class = "rlang_error"
  )

  expect_error(
    to_tibble(list(a = 1, b = 2)),
    class = "rlang_error"
  )

  expect_error(
    to_tibble(NULL),
    class = "rlang_error"
  )

  expect_error(
    to_tibble(),
    class = "missingArgError"
  )
})

test_that("to_tibble errors with invalid keyword input", {
  expect_error(
    to_tibble(test_flowset, "invalid_keyword"),
    class = "rlang_error"
  )

  expect_error(
    to_tibble(test_flowset, "all", "bad"),
    class = "rlang_error"
  )
})

# Default Behavior Tests -------------------------------------------------------

test_that("to_tibble returns all data by default", {
  result <- test_flowset |> to_tibble()

  expect_s3_class(result, "tbl_df")
  expect_shape(result, dim = c(3,4))
  expect_named(result, c("sample_names", "exprs", "keywords", "meta_data"))
})

test_that("to_tibble returns all data with 'all' keyword", {
  result <- test_flowset |> to_tibble("all")

  expect_s3_class(result, "tbl_df")
  expect_shape(result, dim = c(3,4))
  expect_named(result, c("sample_names", "exprs", "keywords", "meta_data"))
})

# Individual Keyword Tests -----------------------------------------------------

test_that("to_tibble returns only sample_names when requested", {
  result <- to_tibble(test_flowset, "sample_names")

  expect_s3_class(result, "tbl_df")
  expect_named(result, "sample_names")
  expect_shape(result, dim = c(3,1))
  expect_type(result$sample_names, "character")
  expect_identical(result$sample_names, rownames(flowCore::pData(test_flowset)))
})

test_that("to_tibble returns only exprs when requested", {
  result <- to_tibble(test_flowset, "exprs")

  expect_s3_class(result, "tbl_df")
  expect_named(result, "exprs")
  expect_shape(result, dim = c(3,1))
  expect_type(result$exprs, "list")
  expect_length(result$exprs, length(test_flowset))

  # Check that each element is a matrix
  expect_true(all(sapply(result$exprs, is.matrix)))
})

test_that("to_tibble returns only keywords when requested", {
  result <- to_tibble(test_flowset, "keywords")

  expect_s3_class(result, "tbl_df")
  expect_named(result, "keywords")
  expect_shape(result, dim = c(3,1))
  expect_type(result$keywords, "list")
  expect_equal(length(result$keywords), length(test_flowset))

  # Check that each element is a list of keywords
  expect_true(all(sapply(result$keywords, is.list)))
})

test_that("to_tibble returns only meta_data when requested", {
  result <- to_tibble(test_flowset, "meta_data")

  expect_s3_class(result, "tbl_df")
  expect_named(result, "meta_data")
  expect_shape(result, dim = c(3,1))

  # Check that meta_data matches pData
  expect_equal(result[[1]], flowCore::pData(test_flowset))
})

# Multiple Keyword Tests -------------------------------------------------------

test_that("to_tibble handles multiple keywords", {
  result <- to_tibble(test_flowset, "sample_names", "exprs")

  expect_s3_class(result, "tbl_df")
  expect_shape(result, dim = c(3,2))
  expect_named(result, c("sample_names", "exprs"))
})

test_that("to_tibble handles three keywords", {
  result <- to_tibble(test_flowset, "sample_names", "exprs", "keywords")

  expect_s3_class(result, "tbl_df")
  expect_shape(result, dim = c(3,3))
  expect_named(result, c("sample_names", "exprs", "keywords"))
})

test_that("to_tibble handles all keywords except one", {
  result <- to_tibble(test_flowset, "sample_names", "exprs", "keywords")

  expect_s3_class(result, "tbl_df")
  expect_false("meta_data" %in% names(result))
  expect_true(all(c("sample_names", "exprs", "keywords") %in% names(result)))
})

# Output Structure Tests -------------------------------------------------------

test_that("to_tibble output has correct structure", {
  result <- to_tibble(test_flowset)

  # Check it's a tibble
  expect_s3_class(result, "tbl_df")

  # Check number of rows equals number of samples
  expect_equal(nrow(result), length(test_flowset))

  # Check each column type
  expect_type(result$sample_names, "character")
  expect_type(result$exprs, "list")
  expect_type(result$keywords, "list")
  expect_type(result$meta_data, "list")
})

test_that("sample_names matches flowSet sample names", {
  result <- to_tibble(test_flowset, "sample_names")

  expect_equal(
    result$sample_names,
    rownames(flowCore::pData(test_flowset))
  )
})

test_that("exprs contains correct matrices", {
  result <- to_tibble(test_flowset, "exprs")

  # Check number of matrices
  expect_equal(length(result$exprs), length(test_flowset))

  # Check each matrix matches the flowFrame exprs
  for (i in seq_along(result$exprs)) {
    expect_equal(
      result$exprs[[i]],
      flowCore::exprs(test_flowset[[i]])
    )
  }
})

test_that("keywords contains correct keyword lists", {
  result <- to_tibble(test_flowset, "keywords")

  # Check number of keyword lists
  expect_equal(length(result$keywords), length(test_flowset))

  # Check each keyword list matches the flowFrame keywords
  for (i in seq_along(result$keywords)) {
    expect_equal(
      result$keywords[[i]],
      flowCore::keyword(test_flowset[[i]])
    )
  }
})

test_that("meta_data matches pData", {
  result <- to_tibble(test_flowset, "meta_data")

  expect_equal(
    result[[1]],
    flowCore::pData(test_flowset)
  )
})

# Edge Cases -------------------------------------------------------------------

test_that("to_tibble works with single sample flowSet", {
  single_sample <- test_flowset[1]
  result <- to_tibble(single_sample)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1)
  expect_named(result, c("sample_names", "exprs", "keywords", "meta_data"))
})

test_that("to_tibble handles duplicate keyword specifications", {
  # Silently irnogred
  expect_no_error(
    to_tibble(test_flowset, "exprs", "exprs")
  )
})

test_that("to_tibble works with all keyword mixed with specific keywords", {
  # When "all" is present, it should return all data
  result <- to_tibble(test_flowset, "all", "sample_names")

  expect_s3_class(result, "tbl_df")
  expect_named(result, c("sample_names", "exprs", "keywords", "meta_data"))
})
