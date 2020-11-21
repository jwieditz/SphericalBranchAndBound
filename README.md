# Spherical Branch And Bound Algorithms

This projects includes an R package containing a branch and bound algorithm for computing Fréchet-p-means on the circle and the 2-sphere. Moreover, we provide a wrapper to easily extend these algorithms also to spheres of higher dimension. This wrapper demands as an input:

* an initial triangulation SET of the sphere,
* a procedure INIT which computes for a given spherical triangle its size, a lower and an upper bound of the Fréchet function on this triangle,
* a branching rule BRANCH,
* a rule MID to compute the midpoint of a triangle.

This repository is supplementary to [Eichfelder, G., Hotz, T., Wieditz, J. (2019). An algorithm for computing Fréchet means on the sphere.](https://link.springer.com/article/10.1007/s11590-019-01415-y)

| ![Result of SBB](https://github.com/jwieditz/SphericalBranchAndBound/blob/jwieditz-patch-1/application_example.png) | 
|:--:| 
| *An <img src="https://render.githubusercontent.com/render/math?math=(\varepsilon, \delta)"> approximation computed using the SBB algorithm applied to an example data set.* |

# The Spherical Branch and Bound (SBB) package

To use the $\mathbb{S}$BB R-package follow the steps below:

1. Install the R-package SphericalBranchAndBound via

	`library(remotes)`

	`install_github('jwieditz/SphericalBranchAndBound/MiSeal')`.
2. Load the library via `library(SphericalBranchAndBound)`.
3. For an example on the circle, run `example(SBB.circle)`.
4. For an example on the 2-sphere, run `example(SBB.sphere)`.
