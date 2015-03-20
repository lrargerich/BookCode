function [pred] = SoftmaxPredict(model, X)

theta = model.theta;  % this provides a numClasses x inputSize matrix
pred = zeros( size(X, 1),1);
k = size(theta, 1);

M = X*theta';
M = bsxfun(@minus, M, max(M, [], 2));
expM = exp(M);

% normalized class probabilities
h = expM ./ repmat(sum(expM, 2), 1,k);

[predValue, pred] = max(h,[],2);

end

