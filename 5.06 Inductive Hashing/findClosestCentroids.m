function idx = findClosestCentroids(X, centroids)

  K = size(centroids, 1);
  idx = zeros(size(X,1), 1);

  for i = 1:size(X,1)
    min = 999999999999;
    position = 0;
    for j = 1:size(centroids,1)
      dist = sum((X(i,:) - centroids(j,:)).^2);
      if dist < min
		    min = dist;
		    position = j;
	    end
    end
    idx(i) = position;
  end  
end

