function [cen,idx]=KmeansCoreset2(x,coreset,k)
[cen,idx2]=Kmeans(coreset,k);
idx=findClosestCentroids(x,cen);
cen = computeCentroids(x, idx, k);
idx=findClosestCentroids(x,cen);
end
