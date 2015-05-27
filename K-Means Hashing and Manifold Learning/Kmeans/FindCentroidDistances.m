function distances = FindCentroidDistances(X, centroids,delta)
  distances=sparse(size(X,1),size(centroids,1));
  for i = 1:size(X,1)
    if (mod(i,1000)==0)
        fprintf('Processed %d points\n',i);
    end
    differences = bsxfun(@minus,X(i,:),centroids);
    dists = sum(differences.^2,2);
    dists(dists<delta)=0;
    distances(i,:)=dists;
  end  
end