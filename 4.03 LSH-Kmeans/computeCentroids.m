function centroids = computeCentroids(X, centroids,idx, K)
[m n] = size(X);
for i = 1:K
  if sum(idx==i)>0
    centroids(i,:)= mean(X(idx==i,:),1);
  end
end
end

