function centroids = ComputeCentroids(X, centroids,idx, K)
for i = 1:K
  if sum(idx==i)>0
    centroids(i,:)= mean(X(idx==i,:),1);
  end
end
end

