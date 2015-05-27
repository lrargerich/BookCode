function idx = FindClosestCentroids2(X, centroids)
  for i = 1:size(X,1)
    differences = bsxfun(@minus,X(i,:),centroids);
    distances = sum(differences.^2,2);
    [distance,position]=min(distances);
    idx(i) = position;
  end  
end

