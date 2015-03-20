% X is a matrix of m points by n features
% we compute a super-dictionary D of k features
% and a sparse assignment matrix of kxm.
% L is the number of atoms per representation
function [D,S,J]=KSVD(X,k,L,max_iter,D)
if ~exist('max_iter','var')
    max_iter=10;
end
J=[];
m = size(X,1);
n = size(X,2);
if ~exist('D','var')
    D=rand(n,k);
    D=ColNormalize(D);
end
S = MatchingPursuit(X,D,L);
[D,S] = UpdateDictionary(X,D,S); 
D=ColNormalize(D);
for iter=1:max_iter
    S = MatchingPursuit(X,D,L,S);
    [D,S] = UpdateDictionary(X,D,S); 
    D=ColNormalize(D);
    error = sum(sum((X'-D*S).^2));
    J=[J;error];
    sparsity = (1-(nnz(S)/(k*m)))*100;
    fprintf('Iteration %d Reconstruction error is %f sparsity is %f%% \n',iter,error,sparsity);
end
end