function [S,A,taudp] = disjoint_support(S)
%DISJOINT_SUPPORT Apply hard thresholding to obtain disjoint supports for 
% the columns of S. Also create a maximum-likelihood sub-partition.

S=max(S,0);                     % Take non-negative part of S
S_descend=sort(S,2,'descend');  % Sort to find largest element in each row
taudp=max(S_descend(:, 2));     % Take largest non-leading element
S(S<=taudp)=0;                  % Apply hard thresholding
					
[M,A]=max(S,[],2);  % Find column with largest element, by row
A(M==0)=0;          % Suppress zero rows
