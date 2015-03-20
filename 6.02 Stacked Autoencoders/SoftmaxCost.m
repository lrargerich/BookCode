function [cost, grad] = SoftmaxCost(theta,X,y, k, n, lambda)

theta = reshape(theta, k, n);

m = size(X, 1);

y_matrix = full(sparse(1:m,y, 1));
cost = 0;

thetagrad = zeros(k, n);

M = X*theta';

M = bsxfun(@minus, M, max(M, [], 2));

expM = exp(M);

% normalized class probabilities
h = expM ./ repmat(sum(expM, 2), 1,k);

cost = -sum(sum(y_matrix .* log(h))) / m + 0.5 * lambda * sum(sum(theta.^2));
thetagrad = (X' * (y_matrix-h))' ./ (-m) + lambda * theta;

grad = [thetagrad(:)];
end

