function centroids = KmeansPlusPlus(X,k)
    centroids = [X(floor(rand()*size(X,1))+1,:)];
    for i=1:(k-1)
        dists = DistanceToClosestCentroid(X,centroids);
        probs = dists/sum(dists);
        k2 = X(find(rand<cumsum(probs),1,'first'),:);
        centroids = [centroids;k2];
    end
end
