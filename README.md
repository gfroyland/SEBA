# SEBA
Sparse EigenBasis Approximation -- Code for finding a sparse basis for the span of an input collection of vectors.

# Usage

S=SEBA(V), where the columns of V are input data vectors and the columns of S are output sparse vectors.
The column space of S approximates the column space of V, with the columns of S chosen to be sparse.
Usage of SEBA.m and other code in the repository is illustrated in the journal article below.

# Applications 

SEBA is useful in all settings where individual features need to be separated or disentangled from a generic basis of data vectors.
For example, as a post-processing step for spectral clustering, replacing e.g. k-means or other methods that enforce a partitioning of the data.  SEBA is specifically designed to not enforce a partition of the data, although it should find a partition if this is appropriate. Likelihood of membership in a cluster/feature is obtained/retained, in contrast to k-means.

# Examples

## Manifold geometry 

<img width="800"  alt="pepsiblob5" src="https://github.com/user-attachments/assets/ddd308ee-c32c-48c4-b76b-3ebbf2568859" /><br>
Left to right:  2nd to 5th <b>eigenvectors</b> of Laplace operator on the planar manfiold shown.

<img width="800"  alt="pepsiblobSEBA" src="https://github.com/user-attachments/assets/f5b56cd4-b85c-47a5-a703-2f455d9aaa28" /><br>
Left to right:  Result of applying SEBA to the leading four eigenvectors (constant vector and 2nd to 4th shown above).  Each geometric ``knob'' is highlighted in a single vector.

## Coherent sets in chaotic cylinder flow

<img width="400" alt="FKSrawevec" src="https://github.com/user-attachments/assets/c863afe5-767c-4d46-894c-3be92bdf9bf8" /><br>
Left to right:  Leading six eigenvectors of the dynamic Laplace operator.

<img width="400" alt="FKSseba" src="https://github.com/user-attachments/assets/af16bfcd-6dc6-44fc-8221-c1558cfdfba4" /><br>
Left to right:  Result of SEBA applied to these six eigenvectors.  Each coherent vortex is highlighted in a single vector.

<img width="400"  alt="top8evecs_6yr_month1_hatfunc_bluewhitered" src="https://github.com/user-attachments/assets/ea16eb67-73a1-47fa-b1be-ab86d4f3b5e0" />
<img width="400"  alt="top8rotevecs_from9evecs_6yr_month1_hatfunc_red" src="https://github.com/user-attachments/assets/1f774534-2900-460e-9c0e-d9a2933888ae" />

# Reference

Gary Froyland, Christopher P. Rock, and Konstantinos Sakellariou.
Sparse eigenbasis approximation: multiple feature extraction across spatiotemporal scales with application to coherent set identification. Communications in Nonlinear Science and Numerical Simulation, 77:81-107, 2019. https://arxiv.org/abs/1812.02787


