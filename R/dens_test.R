#' McCrary Sorting Test
#' 
#' Run the McCracy test for manipulation of the forcing variable
#' 
#' @param rdd_object object of class rdd_data
#' @param bin the binwidth (defaults to \code{2*sd(runvar)*length(runvar)^(-.5)})
#' @param bw the bandwidth to use (by default uses bandwidth selection calculation from McCrary (2008))
#' @param plot Whether to return a plot. Logical, default to TRUE. 
#' @param \ldots Further arguments passed to the unexported \code{DCdensity} function. 
#' @description
#' This calls the original \code{DCdensity} function which was in the package \code{rdd} by Drew Dimmery,
#' which has been archived and is now internally stored in the Rddtools package. 
#' @references McCrary, Justin. (2008) "Manipulation of the running variable in the regression discontinuity design: A density test," \emph{Journal of Econometrics}. 142(2): 698-714. \doi{http://dx.doi.org/10.1016/j.jeconom.2007.05.005}
#' @export
#' @examples
#' data(house)
#' house_rdd <- rdd_data(y=house$y, x=house$x, cutpoint=0)
#' dens_test(house_rdd)



dens_test <- function(rdd_object, bin = NULL, bw = NULL, plot = TRUE, ...) {
    checkIsRDD(rdd_object)
    cutpoint <- getCutpoint(rdd_object)
    x <- getOriginalX(rdd_object)
    test <- try(DCdensity(runvar = x, cutpoint = cutpoint, bin = bin, bw = bw, plot = plot, ext.out = TRUE, ...), silent = TRUE)
    if (inherits(test, "try-error")) {
        warning("Error in computing the density, returning a simple histogram", if (is.null(bin)) 
            " with arbitrary bin" else NULL)
        if (is.null(bin)) {
            test <- try(DCdensity(rdd_object$x, cutpoint, bin = bin, bw = 0.2, ext.out = TRUE, plot = FALSE), silent = TRUE)
            bin <- test$binsize
        }
        max_x <- max(rdd_object$x, na.rm = TRUE)
        seq_breaks <- seq(from = min(rdd_object$x, na.rm = TRUE), to = max_x, by = bin)
        if (max_x > max(seq_breaks)) 
            seq_breaks <- c(seq_breaks, max_x + 0.001)
        hist(rdd_object$x, breaks = seq_breaks)
        abline(v = cutpoint, col = 2, lty = 2)
    }
    
    test.htest <- list()
    test.htest$statistic <- c(`z-val` = test$z)
    test.htest$p.value <- test$p
    test.htest$data.name <- deparse(substitute(rdd_object))
    test.htest$method <- "McCrary Test for no discontinuity of density around cutpoint"
    test.htest$alternative <- "Density is discontinuous around cutpoint"
    test.htest$estimate <- c(Discontinuity = test$theta)
    test.htest$test.output <- test
    class(test.htest) <- "htest"
    return(test.htest)
} 
