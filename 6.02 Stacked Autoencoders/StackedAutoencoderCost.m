function [ cost, grad ] = StackedAutoencoderCost(theta, inputSize, h, ...
                                              k, netconfig, ...
                                              lambda, X, y)
                                          
X=X';                                          
%% Unroll softmaxTheta parameter
% We first extract the part which compute the softmax gradient
softmax_theta = reshape(theta(1:h*k), k, h);

% Extract out the "stack"
stack = params2stack(theta(h*k+1:end), netconfig);

% Initialize gradient stack
stackgrad = cell(size(stack));

% You might find these variables useful
m = size(X, 2);
groundTruth = full(sparse(y, 1:m, 1));

depth = numel(stack);
z = cell(depth+1,1);
a = cell(depth+1, 1);
a{1} = X;

for layer = (1:depth)
  z{layer+1} = stack{layer}.w * a{layer} + repmat(stack{layer}.b, [1, size(a{layer},2)]);
  a{layer+1} = Sigmoid(z{layer+1});
end

M = softmax_theta * a{depth+1};
M = bsxfun(@minus, M, max(M));
p = bsxfun(@rdivide, exp(M), sum(exp(M)));

cost = -1/m * groundTruth(:)' * log(p(:)) + lambda/2 * sum(softmax_theta(:) .^ 2);
softmaxThetaGrad = -1/m * (groundTruth - p) * a{depth+1}' + lambda * softmax_theta;

d = cell(depth+1);

d{depth+1} = -(softmax_theta' * (groundTruth - p)) .* a{depth+1} .* (1-a{depth+1});

for layer = (depth:-1:2)
  d{layer} = (stack{layer}.w' * d{layer+1}) .* a{layer} .* (1-a{layer});
end

for layer = (depth:-1:1)
  stackgrad{layer}.w = (1/m) * d{layer+1} * a{layer}';
  stackgrad{layer}.b = (1/m) * sum(d{layer+1}, 2);
end

grad = [softmaxThetaGrad(:) ; stack2params(stackgrad)];
end
