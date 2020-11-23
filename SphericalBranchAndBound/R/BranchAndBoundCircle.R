#' The spherical branch and bound algorithm for data on the circle.
#'
#' @param x Data points on the circle given in angular coordinates.
#' @param ... Parameters which are passed to the BranchAndBound wrapper, see. BranchAndBound.
#'
#' @return A list of intervals representing a (eps, delta)-approximation of the set of Fréchet means.
#' @author Johannes Wieditz
#'
#' @examples
#' \donttest{
#'   set.seed(42)
#'   x    <- runif(100, -pi, pi)
#'   SBBC <- SBB.circle(x)
#' }
#' @export

SBB.circle <- function(x, ...) BranchAndBound( SET = list(list(left = -pi, right = pi)),
                                           INIT = init.acc.circle,
                                           BRANCH = branch.circle,
                                           MID = mid.circle,
                                           p = 2,
                                           eps = 1e-2,
                                           delta = 1e-1,
                                           eta = 1e-8,
                                           dimension = 1,
                                           darc = darc.circle )(data = x)
