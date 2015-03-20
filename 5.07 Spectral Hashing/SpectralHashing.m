%% X is a m x n matrix, k is the number of bits to use
%% the result is an m x k binary matrix with the codes
function codes = SpectralHashing(X,k,sigma,W)
if ~exist('sigma','var')
  sigma=1;
end
if ~exist('W','var')
  W = CreateAffinityMatrix(X,sigma);
end
D = diag(sum(W));
L = D-W;
[V,S]=eigs(L,k);
codes=V>0;
end