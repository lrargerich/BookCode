function reduced = KmeansGammaReducer(X,centroids,gamma)
	% Init return matrix
    k=size(centroids,1);
	reduced = zeros(size(X,1),k);
	% Compute distances
	for i = 1:size(X,1)
		for j= 1:k
			reduced(i,j)=MapDim(norm(X(i,:)-centroids(j,:),2),gamma);
	end
end