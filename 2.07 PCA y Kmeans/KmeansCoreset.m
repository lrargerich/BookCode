function [cen,idx]=KmeansCoreset(x,coreset,k)
[cen,idx2]=Kmeans(coreset,k);
idx=findClosestCentroids(x,cen);
end
