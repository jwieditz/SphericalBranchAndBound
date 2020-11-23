#' The Fréchet-p-sample function.
#'
#' @param m Point at which the Fréchet function is evaluated.
#' @param d Metric on the considered space.
#'
#' @return Value of the Fréchet function in m.
#' @author Johannes Wieditz

Fnhat <- function (m, d, ...){

  1/length(x) * sum( sapply(x, d, y = m)^p )

}

#' Pushing an element to a list. The element is added at the end of the list.
#' @param L A list.
#' @param x An element to be pushed to the list.
#'
#' @return The list L with appended x as last element.
#' @author Johannes Wieditz

push <- function (L, x){

  c( L, list(x) )
}

#' Delete an element from a list.
#' @param L A list.
#' @param x An element to be deleted from the list. If x is not contained in the list, then the output is again the list passed.
#'
#' @result The list L without the element x.
#' @author Johannes Wieditz

delete <- function(L, x){

  L[[ Position( function(y) identical(y, x), L) ]] <- NULL
  L
}

#' Determine the index of the first element of the list with the lowest element of the attribut entry.
#'
#' @param L A list.
#' @param entry An attribute of an element of the list.
#'
#' @result The index of the first element of the list with the lowest element of the attribute entry.
#' @author Johannes Wieditz

get.min.index <- function(L, entry){

  which.min( sapply(L, function(x) x[[entry]]) )[1]

}

#' Determine the index of the first element of the list with the highest element of the attribut entry.
#'
#' @param L A list.
#' @param entry An attribute of an element of the list.
#'
#' @result The index of the first element of the list with the highest element of the attribute entry.
#' @author Johannes Wieditz

get.max.index <- function(L, entry){

  which.max( sapply(L, function(x) x[[entry]]) )[1]

}

#' Output function for the results on the circle.
#'
#' @param A List which has to be output.
#'
#' @result The list passed convertes as a vector.
#' @author Johannes Wieditz

output <- function (A){

  D <- data.frame( do.call(rbind, A) )
  D[ order(unlist(D[,1])), ]

}
