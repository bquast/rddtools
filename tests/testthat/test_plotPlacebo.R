# load the rddtools package
library(rddtools)

# load the example data set
data(house)

# create rdd_data sets
reg_nonpara <- rdd_reg_np(rdd_object=rdd_data(y=house$y, x=house$x, cutpoint=0) )
reg_para <- rdd_reg_lm(rdd_object=rdd_data(y=house$y, x=house$x, cutpoint=0) )

# store plot in object
placeboplot <- plotPlacebo(reg_nonpara, device="ggplot")
placeboplot_lm <- plotPlacebo(reg_para, device="ggplot")


test_that("rd: output values match", {
  expect_equal( length(placeboplot),  8 )
  expect_equal( placeboplot$cutpoint[9], 0.563925 )
})

test_that("output=ggplot works", {
  expect_s3_class(plotPlacebo(reg_nonpara, output = "ggplot"), class = "ggplot")
  expect_s3_class(plotPlacebo(reg_para, output = "ggplot"), class = "ggplot")
})
