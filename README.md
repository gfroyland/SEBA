# SEBA
Sparse EigenBasis Approximation -- Code for finding a sparse basis for the span of an input collection of vectors.

# Usage

S=SEBA(V), where the columns of V are input data vectors and the columns of S are output sparse vectors.
The column space of S approximates the column space of V, with the columns of S chosen to be sparse.
Usage of SEBA.m and other code in the repository is illustrated in the journal article below.

# Applications 

SEBA is useful in all settings where individual features need to be separated or disentangled from a generic basis of data vectors.
For example, as a post-processing step for spectral clustering, replacing e.g. k-means or other methods that enforce a partitioning of the data.  SEBA is specifically designed to not enforce a partition of the data, although it should find a partition if this is appropriate. Likelihood of membership in a cluster/feature is obtained/retained, in contrast to k-means.

# Reference

Gary Froyland, Christopher P. Rock, and Konstantinos Sakellariou.
Sparse eigenbasis approximation: multiple feature extraction across spatiotemporal scales with application to coherent set identification. Communications in Nonlinear Science and Numerical Simulation, 77:81-107, 2019. https://arxiv.org/abs/1812.02787


