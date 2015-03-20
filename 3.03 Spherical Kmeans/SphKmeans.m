function [centroids,s] = SphKmeans(X,k,eps)
	% Spherical K-Means
	if ~exist('eps','var'), eps=0.05; end
	% first step: Row Normalize X
	X = RowNormalize(X);
	% Second step create Random Centroids
	centroids = rand(k,size(X,2));
	centroids = RowNormalize(centroids);
	error = 99999999999999;
	iter = 0;
	% AQUI AGREGAR LOOP HASTA CONVERGENCIA
	while (error>eps)
		% Create matrix of dot products between points and each centroid
		D = X*centroids';
		% 'Now create matrix s with assignments of points to centroids;
		s = repmat(max(d,[],2),1,size(d,2)) .* (d==repmat(max(d,[],2),1,size(d,2)))
		old_centroids = centroids;
		iter = iter+1;
		centroids = (s'*X) + centroids;
		centroids = RowNormalize(centroids);
		error = (sum(sum(centroids-old_centroids)));
    	error = abs(error);
	end
	fprintf('Finished in %d iterations\n',iter)
	s= (s~=0) * (1:size(s,2))';
end