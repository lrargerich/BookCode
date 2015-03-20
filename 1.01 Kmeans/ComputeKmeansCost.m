function cost = ComputeKmeansCost(X,centroids,idx)
    cost =0;
    for i=1:size(X,1)
        cost = cost + sum((X(i,:)-centroids(idx(i),:)).^2);
    end
end