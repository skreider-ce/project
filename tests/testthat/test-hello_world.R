testthat::test_that("hello_world prints to console appropriately", {
  testthat::expect_output(hello_world(), "HELLO ExampleNameium!")
  testthat::expect_output(hello_world("Scott"), "HELLO Scott!")
})
