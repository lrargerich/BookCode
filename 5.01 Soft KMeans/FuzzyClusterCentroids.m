function centroids = FuzzyClusterCentroids(X,clusters)
	% Compute cluster centroids given data X and cluster assignments
	clusters = clusters.^2;
	centroids = clusters' * X;
	centroids = (centroids ./ repmat(sum(clusters)',1,size(centroids,2)));
end