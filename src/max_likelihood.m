function [S,A] = max_likelihood(S)
%MAX_LIKELIHOOD Apply maximum likelihood to obtain disjoint supports 
% from the columns of S, resolving ties arbitrarily. Also create the 
% corresponding sub-partition. 

[M,A]=max(S,[],2);  % Find column with largest element, by row
A(M<=0)=0;          % Suppress zero rows
S(:)=0;
r=size(S,2);
for i=1:r
    S(A==i,i)=M(A==i); % Set original values for non-zero elements.
end
