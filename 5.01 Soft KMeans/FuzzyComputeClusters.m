function clusters = FuzzyComputeClusters(X,centroids)
	% compute the matrix of assignment to centroids
	% Using euclid distance: d = norm( x1 - x2 , 2 );
	[n,d] = size(X);
	[clus,d] = size(centroids);
	clusters = zeros(n,clus);
	for i = 1:n
		x = X(i,:);
    	for k = 1:clus
    		% Compute distance from point x to centroid k
    		sum = 0;
    		cck = norm(x-centroids(k,:));
    		for j=1:clus
    			sum = sum + (cck/(norm(x-centroids(j,:))))^2;
    		end
    		clusters(i,k) = 1/sum;
    	end
	end
end