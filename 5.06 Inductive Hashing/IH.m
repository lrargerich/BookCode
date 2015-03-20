%% Inductive Hashing
%% X is a m x n data matrix
%% k is the number of bits per code
%% reduxfunction is a function that takes
%% a mxn matrix and reduces dimensiones to mxk
%% sigma is the width to consider two points neigbors
%% base_size is the size of the base
%% returns C m x k a binary matrix.
function [C,W,base]=IH(X,k,reduxfunction,sigma,base_size)
[m,n]=size(X);
if ~exist('sigma','var')
  sigma=1;
end
if ~exist('base_size','var')
  base_size=400;
end
% first step is to compute the base
base = Kmeans(X,base_size,30);
% now base is base_size x n, reduce it to k dims
Y = reduxfunction(base,k);
% now compute the W matrix
W = ComputeCentroidAffinity(X,base,sigma);
% Now compute output
C = ((W*Y)>0);
end
