function [centroids, idx] = Kmeans(X, k, method, eps)
if ~ exist('eps', 'var')
    eps = 0.05;
end
if ~ exist('method', 'var')
    method = 'points';
end

% Initialize values
[m n] = size(X);

if strcmpi(method, 'points')
    centroids = X(1 + floor(rand(k, 1) * m), :);
elseif strcmpi(method, 'kmeans++')
    centroids = KmeansPlusPlus(X, k);
else
    centroids = (rand(k, size(X, 2)) .* repmat(max(X) - min(X), k, 1)) + repmat(min(X), k, 1);
end

    iter = 0;
    error = 10;
 
    while (error > eps)
        fprintf('Kmeans iteration: %d\n',iter+1);
        idx = FindClosestCentroids(X, centroids);
        old_centroids = centroids;
        centroids = ComputeCentroids(X,centroids, idx, k);
        iter = iter + 1;
        error = (sum(sum(centroids - old_centroids)));
        error = abs(error);
    end
    fprintf('Finished in %d iterations\n', iter)
end
