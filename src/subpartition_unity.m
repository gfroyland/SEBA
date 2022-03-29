function [S,A,taupu] = subpartition_unity(S)
%SUBPARTITION_UNITY Apply hard thresholding to obtain a sub-partition of 
% unity from the columns of S. Also create a maxmimum-likelihood 
% sub-partition.

S=max(S,0);                         % Take non-negative part
S_descend=sort(S,2,'descend');      % Sort each row in descending order
S_sum=cumsum(S_descend,2);          % Must be <=1 for partition of unity
taupu=max([S_descend(S_sum>1);0]);  % Largest element where row sum > 1 
S(S<=taupu)=0;                      % Apply hard thresholding

[M,A]=max(S,[],2);  % Find column with largest element, by row
A(M==0)=0;          % Suppress zero rows
