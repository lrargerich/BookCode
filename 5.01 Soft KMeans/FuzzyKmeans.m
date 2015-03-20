function [centroids,clusters] = FuzzyKmeans(X,k)
	[n,d] = size(X);
	clusters = rand(n,k);
	error = 1;
	iter = 0;
	maxi=max(X);
    mini=min(X);
    range=maxi-mini;
	centroids = bsxfun(@times,rand(k,d),range);
    centroids = bsxfun(@plus,centroids,mini);
	while (error>0.00005)
		old_centroids=centroids;
		centroids = FuzzyClusterCentroids(X,clusters);
		clusters = FuzzyComputeClusters(X,centroids);
		iter = iter+1;
		error = (sum(sum(centroids-old_centroids)));
		error = abs(error);
		
	end
	fprintf('Finished in %d iterations\n',iter)
end

