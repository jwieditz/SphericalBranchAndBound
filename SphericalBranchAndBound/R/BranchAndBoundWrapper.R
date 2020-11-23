#' Branch and Bound  - Wrapper for branch and bound algorithms for computation of an (eps,delta)-approximation.
#'
#' @param SET contains a list of points describing an initial triangulation/ subdivision of the manifold
#' @param INIT generates from SET a list with the following attributes
#' - size
#' - upper bound (ub)
#' - lower bound (lb)
#' @param BRANCH a function which subdivides the passed set (e.g. a triangle)
#' @param MID determines the midpoint of a passed set/ triangle
#' @param p power of the distance in the Fréchet function (cf. Fréchet-p-mean)
#' @param eps tolerance parameter for the function value (eps-minimality). Default is eps = 1e-3.
#' @param delta maximal size of the triangulation. Default is delta = 1e-1.
#' @param eta tolerance parameter for numerical evaluation of inequalities
#' @param dimension dimension of the considered sphere (e.g. 1 for the circle)
#'
#' @result Provides a function which can computes a (eps, delta)-optimal set for the Fréchet-p-mean.
#' @author Johannes Wieditz

BranchAndBound <- function ( SET, INIT, BRANCH, MID, SIZE, p = 2,  eps = 1e-3, delta = 1e-1, env = parent.frame(), eta = 1e-8, dimension, ... ){

  if(dimension != 1 && dimension!=2){
    print("SBB for this dimension not yet available")
    return()
  }

  function(data, ...){

    # Initialisation.
    x     <- assign("x", data, pos = 1, envir = baseenv())  ## define input x as global
    p     <- assign("p", p, pos = 1, envir = baseenv())     ## define input p as global
    L     <- INIT( SET, x, ... )
    A     <- list()         ## list of eps-optimal minima
    ustar <- -Inf           ## current lower bound
    vact  <- Inf            ## current function value
    vglob <- vact           ## currently lowest function value
    xstar <- L[[ get.min.index(L, "lb") ]]   ## initial (and currently considered) set
    xact  <- xstar          ## set with currently lowest function value
    iter  <- 0              ## number of iterations
    time  <- Sys.time()     ## timer
    toplot<- list()         ## list of points to plot

    ## Branch and bound loop.

    while ( length(L) > 0 ){

      if( iter%% 1000 == 0 ){
        print(paste0("Iterations elapsed: ", iter))
      }

      iter  <- iter + 1
      L     <- delete(L, xstar)

      ## Branch step to divide the set xstar into subsets (subtriangles).
      sB      <- BRANCH(xstar, INIT, MID)
      toplot  <- c( toplot, list( MID(xstar)) ) ## Save division points.

      for ( X in sB ){

        ## Test whether newly generated subsets can contain minima. If so, include into L.
        if( X$lb <= vglob + eta ){

          L <- push(L, X)

          ## Update upper bound.
          if( X$ub <= vact ){
            xact  <- X
            vact  <- X$ub
            vglob <- min( vact, vglob )

            ## Delete sets which cannot contain a minimum anymore.
            for ( i in length(L):1 ) {

              if( L[[i]]$lb >= vglob + eta ){ L[[i]] <- NULL }

            }
          }
        }
      }

      if( length(L) > 0 ){

        ## Choose first element of the list L with the lowest lower bound.
        xstar <- L[[ get.min.index(L, "lb") ]]

        ## Choose lowest lower bound found so far.
        ustar <- xstar$lb

        ## Bound step - Check for eps-minimality.
        while ( length(L) > 0 && (vact - ustar <= eps/2) ){

          ## Push xact to the list A of eps-minimal points if still contained in L.
          if( list(xact) %in% L ){
            if( xact$size <= delta ){
              A <- push(A, xact)
              L <- delete(L, xact)
            }
            else {
              xstar <- xact
              break
            }
          }

          ## Choose a new set/ triangle and new xact.
          if ( length(L) > 0 ){

            ## Define xstar as first element of L with ustar = minimal lower bounds of all elements in L.
            xstar <- L[[ get.min.index(L, "lb") ]]

            ## Compute xact with lowest function value/ upper bound ub in L and update upper bound.
            xact  <- L[[ get.min.index(L, "ub") ]]

            if( dimension == 1 ){
              vact  <- Fnhat(MID(xact), d = darc.circle)
            }
            else if( dimension == 2 ){
              vact <- Fnhat(MID(xact), d = darc.sphere)
            }


          }
        }
      }
    }

    if( dimension == 1 ){
      size <- size.circle(A)
    }
    else if( dimension == 2){
      size <- size.sphere(A)
    }
    else{
      size <- NULL
    }

    cat("Time elapsed (sec): ", difftime(Sys.time(), time, units = "secs"), "\n")
    cat("Iterations needed: ", iter, "\n")
    cat("Number of eps-delta minimal points: ", length(A), "\n")
    cat("Precision eps: ", eps, ", precision delta: ", delta, "\n")

    ## Output of all eps-optimal sets in a data frame.
    return( list( output = A, time = difftime(Sys.time(), time, units = "secs"), iter = iter, length = length(A), size = size, toplot = toplot ) )
  }
}
