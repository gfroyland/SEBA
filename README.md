# SEBA
<b>Sparse EigenBasis Approximation -- Code for finding a sparse basis for the span of an input collection of vectors.</b>

<i>SEBA is useful in all settings where individual features need to be separated or disentangled from a generic basis of data vectors.</i>
For example, as a post-processing step for spectral clustering, replacing e.g. k-means or other methods that enforce a partitioning of the data.  SEBA is specifically designed to <b>not enforce a partition of the data</b>, although it should find a partition if this is appropriate. Likelihood of membership in a cluster/feature is obtained, in contrast to k-means.

Let V be an array whose columns are individual data vectors (for example, eigenvectors arising from a spectral clustering). 
The single matlab function `SEBA.m` or julia function `SEBA.jl` is called as `S=SEBA(V)`.
The output array S is of the same size as V and the columns of S are the transformed sparse basis vectors.
The column space of S approximates the column space of V, with the columns of S chosen to be sparse.

Usage of SEBA and other code in the repository is illustrated in the journal article in the <b>Reference</b> section below.

# Examples

## Manifold geometry 

<img width="600"  alt="pepsiblob5" src="https://github.com/user-attachments/assets/ddd308ee-c32c-48c4-b76b-3ebbf2568859" /><br>
Left to right:  2nd to 5th <b>eigenvectors</b> of Laplace operator on the planar manifold shown.

<img width="600"  alt="pepsiblobSEBA" src="https://github.com/user-attachments/assets/f5b56cd4-b85c-47a5-a703-2f455d9aaa28" /><br>
Left to right:  Result of applying SEBA to the leading four eigenvectors (constant vector and 2nd to 4th shown above).  Each geometric ``knob'' is highlighted in a single vector.



## Coherent sets in chaotic cylinder flow

<img width="600" alt="FKSrawevec" src="https://github.com/user-attachments/assets/c863afe5-767c-4d46-894c-3be92bdf9bf8" /><br>
Left to right:  Leading six eigenvectors of the dynamic Laplace operator.

<img width="600" alt="FKSseba" src="https://github.com/user-attachments/assets/af16bfcd-6dc6-44fc-8221-c1558cfdfba4" /><br>
Left to right:  Result of SEBA applied to these six eigenvectors.  Each coherent vortex is highlighted in a single vector. 


## Coherent sets in the global ocean at 1000m depth

<img width="600"  alt="top8evecs_6yr_month1_hatfunc_bluewhitered" src="https://github.com/user-attachments/assets/ea16eb67-73a1-47fa-b1be-ab86d4f3b5e0" /><br>
Left to right:  Leading eight eigenvectors of the dynamic Laplace operator.

<img width="600"  alt="top8rotevecs_from9evecs_6yr_month1_hatfunc_red" src="https://github.com/user-attachments/assets/1f774534-2900-460e-9c0e-d9a2933888ae" /><br>
Left to right:  Result of SEBA applied to these eight eigenvectors.  Each deep-ocean coherent region is highlighted in a single vector.


# Reference for citing SEBA

Gary Froyland, Christopher P. Rock, and Konstantinos Sakellariou.
Sparse eigenbasis approximation: multiple feature extraction across spatiotemporal scales with application to coherent set identification. Communications in Nonlinear Science and Numerical Simulation, 77:81-107, 2019. https://arxiv.org/abs/1812.02787

# References for example images

<ol>
<li>Gary Froyland.
A tutorial on the dynamic Laplacian. To appear in Proceedings of the 2023 International Congress on Industrial and Applied Mathematics (ICIAM). Springer, 2025. https://web.maths.unsw.edu.au/~froyland/iciam23proceedings_short2.pdf

  <li>
Gary Froyland, Péter Koltai, and Martin Stahn. Computation and optimal perturbation of finite-time coherent sets for aperiodic flows without trajectory integration. <i>SIAM Journal on Applied Dynamical Systems</i>, 19(3):1659–1700, 2020. https://web.maths.unsw.edu.au/~froyland/FKS20.pdf

<li> 
Ryan Abernathey, Christopher Bladwell, Gary Froyland, and Konstantinos Sakellariou.
Deep Lagrangian connectivity in the global ocean inferred from Argo floats. Journal of Physical Oceanography, 52(5):951-963, 2022. https://web.maths.unsw.edu.au/~froyland/ABFS22a.pdf
</ol>

