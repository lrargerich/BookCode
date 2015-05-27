function [centroids,s,s2,error] = OnlineSphKmeans(X,k,max_iter,eps)
	if ~exist('eps','var'), eps=0.005; end
	if ~exist('max_iter','var'), max_iter=20; end
	error = 99999999999999;
	iter = 0;
	fprintf('Running Spherical Kmeans for %d iterations\n', max_iter );
	%s = zeros(size(X,1),k);
	s=sparse(size(X,1),k);
	% Random Initialize Centroids
	fprintf('Initializing Centroids\n');
	centroids = rand(k,size(X,2));
	% Normalize Centroids to have norm=1
	fprintf('Normalizing Centroids\n');
	centroids = RowNormalize(centroids);
	
	fprintf('Entering First Iteration\n');

	while (iter < max_iter) && (error>eps)
		old_centroids = sparse(centroids');
		centroids = zeros(k,size(X,2));
		fprintf('Iteration:%d\n', iter+1 );
		s=sparse(size(X,1),k);
		for i=1:size(X,1);
			if mod(i,1000)==0
				fprintf('Processed %d points\n', i );
			end
			xi = sparse(X(i,:));
			D = xi * old_centroids; 
			[m1,m2] = max(D);
			s(i,m2) = m1;
			centroids = centroids + s(i,:)'*xi; 
		end
		iter = iter+1;
		% Dampening
		centroids = centroids + old_centroids;
		centroids = RowNormalize(centroids);
		error = (sum(sum(centroids-old_centroids)));
    	error = abs(error);
	end
	s2=s;
	fprintf('Finished in %d iterations\n',iter)
	%s = sparse(1,size(X,1));
	s= (s~=0) * (1:size(s,2))';
end