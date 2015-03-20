function [model] = SoftmaxTrain(X,y, k,n, lambda,max_iter)
if ~exist('max_iter', 'var')
    max_iter=400;
end

options.maxIter = max_iter;

% initialize parameters
theta = 0.005 * randn(k * n, 1);

% Use minFunc to minimize the function
addpath minFunc/
options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % softmaxCost.m satisfies this.
minFuncOptions.display = 'on';

[OptTheta, cost] = minFunc( @(p) SoftmaxCost(p, ...
                                   X,y,k, n, lambda), ...
                              theta, options);

% Fold softmaxOptTheta into a nicer format
model.theta = reshape(OptTheta, k, n);
model.n = n;
model.k = k;
                          
end                          
