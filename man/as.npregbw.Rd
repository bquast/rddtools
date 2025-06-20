% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as.npreg.R
\name{as.npregbw}
\alias{as.npregbw}
\alias{as.npreg}
\title{Convert an rdd_reg object to a  \code{npreg} object}
\usage{
as.npregbw(x, ...)

as.npreg(x, ...)
}
\arguments{
\item{x}{Object of class \code{rdd_reg} created by \code{\link{rdd_reg_np}} or \code{\link{rdd_reg_lm}}}

\item{\ldots}{Further arguments passed to the \code{\link[np]{npregbw}} or \code{\link[np]{npreg}}}
}
\value{
An object of class \code{npreg} or \code{npregbw}
}
\description{
Convert an rdd_object to a non-parametric regression \code{npreg} from package \code{np}
}
\details{
This function converts an rdd_reg object into an \code{npreg} object from package \code{np}
Note that the output won't be the same, since \code{npreg} does not offer a triangular kernel, but a Gaussian or Epanechinkov one. 
Another reason why estimates might differ slightly is that \code{npreg} implements a multivariate kernel, while rdd_reg 
proceeds as if the kernel was univariate. A simple solution to make the multivariate kernel similar to the  univariate one 
is to set the bandwidth for x and Dx to a large number, so that they converge towards a constant, and one obtains back the univariate kernel.
}
\examples{
# Estimate ususal rdd_reg:
 data(house)
 house_rdd <- rdd_data(y=house$y, x=house$x, cutpoint=0)
 reg_nonpara <- rdd_reg_np(rdd_object=house_rdd)

## Convert to npreg:
 reg_nonpara_np <- as.npreg(reg_nonpara)
 reg_nonpara_np
 rdd_coef(reg_nonpara_np, allCo=TRUE, allInfo=TRUE)

## Compare with result obtained with a Gaussian kernel:
 bw_lm <- dnorm(house_rdd$x, sd=rddtools:::getBW(reg_nonpara))
 reg_nonpara_gaus <- rdd_reg_lm(rdd_object=house_rdd, w=bw_lm)
 all.equal(rdd_coef(reg_nonpara_gaus),rdd_coef(reg_nonpara_np)) 
}
\seealso{
\code{\link{as.lm}} which converts \code{rdd_reg} objects into \code{lm}.
}
