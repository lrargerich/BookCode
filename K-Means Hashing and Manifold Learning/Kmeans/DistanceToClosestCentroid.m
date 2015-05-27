function dists = DistanceToClosestCentroid(X,centroids)
    dists = zeros(size(X,1),1);
    for i=1:size(X,1)
       min_distance = 999999;
       for j=1:size(centroids,1)
           distance=(norm(X(i,:)-centroids(j,:)));
           if distance<min_distance
               min_distance=distance;
           end      
       end
        dists(i) = min_distance;
    end   
end