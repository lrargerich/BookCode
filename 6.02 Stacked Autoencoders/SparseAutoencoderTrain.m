%% Train a neural network with 1 hidden layer of h units
%% X is an mxn matrix (normalize it please!)
%% y is a labels vector
%% h is the number of hidden units
%% lambda is our beloved regularization parameter
function model = SparseAutoencoderTrain(X,h,lambda,rho,beta,max_iter)
if ~exist('max_iter','var')
    max_iter=400;
end
X=X';
[n,m]=size(X);
theta = InitializeParameters(h, n);

%  Use minFunc to minimize the function
addpath minFunc/
options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';


[theta, cost] = minFunc( @(p) SparseAutoencoderCost(p, ...
                                   n,h, ...
                                   lambda, rho, ...
                                   beta, X), ...
                              theta, options);
model.cost=cost;
model.theta_ih = reshape(theta(1:h*n), h, n);
model.theta_ho = reshape(theta(h*n+1:2*h*n), n, h);
model.b_ih = theta(2*h*n+1:2*h*n+h);
model.b_ho = theta(2*h*n+h+1:end);
model.h=h;
model.n=n;
model.lambda=lambda;
model.rho=rho;
model.beta=beta;
end