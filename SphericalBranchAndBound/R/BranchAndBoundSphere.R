#' The spherical branch and bound algorithm for data on the 2-sphere.
#'
#' @param x Data points on the circle given in angular coordinates.
#' @param ... Parameters which are passed to the BranchAndBound wrapper, see. BranchAndBound.
#'
#' @return A list of intervalls representing a (eps, delta)-approximation of the set of Fréchet means.
#' @author Johannes Wieditz
#'
#' @examples
#' \donttest{
#'   set.seed(42)
#'   x <- list()
#'   for( k in 1:10 ){
#'
#'      x <- c(x, list(norm.vec(rnorm(3))))
#'   }
#'   SBBS <- SBB.sphere(x)
#' }
#'
#' @export

SBB.sphere <- function(x, ...) BranchAndBound( SET = list(list(d1 = c(1,0,0), d2 = c(0,1,0), d3 = c(0,0,1)),
                                                                      list(d1 = c(0,1,0), d2 = c(-1,0,0), d3 = c(0,0,1)),
                                                                      list(d1 = c(-1,0,0), d2 = c(0,-1,0), d3 = c(0,0,1)),
                                                                      list(d1 = c(0,-1,0), d2 = c(1,0,0), d3 = c(0,0,1)),
                                                                      list(d1 = c(1,0,0), d2 = c(0,1,0), d3 = c(0,0,-1)),
                                                                      list(d1 = c(0,1,0), d2 = c(-1,0,0), d3 = c(0,0,-1)),
                                                                      list(d1 = c(-1,0,0), d2 = c(0,-1,0), d3 = c(0,0,-1)),
                                                                      list(d1 = c(0,-1,0), d2 = c(1,0,0), d3 =c(0,0,-1))),
                                           INIT = init.acc.sphere,
                                           BRANCH = branch.sphere,
                                           MID = mid.sphere,
                                           p = 2,
                                           eps = 1e-1,
                                           delta = 1e-1,
                                           eta = 1e-8,
                                           dimension = 2,
                                           darc = darc.sphere )(data = x)
