function [cen,idx]=KmeansRedux(X,k,dims)
if ~exist('dims','var')
    dims=GuessRedux(X);
end
[u,s,v]=svd(X);
% Cluster in reduced dimensions
[cen2,idx]=Kmeans(u(:,1:dims),k);
% Recalculate centroids in original space
cen=computeCentroids(X,idx,k);
end