function [idx,D] = FindClosestCentroids(X, centroids)
% Faster version without for loops!
m = size(X,1); n = size(centroids,1);
centroidst = centroids';
XX = sum(X.*X,2);
YY = sum(centroidst.*centroidst,1);
D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*centroidst;
[Dmin,idx]=min(D,[],2);
end


