%% Train a neural network with 1 hidden layer of h units
%% X is an mxn matrix (normalize it please!)
%% y is a labels vector
%% h is the number of hidden units
%% lambda is our beloved regularization parameter
function model = NNTrain(X,y,h,k,lambda,max_iter)
if ~exist('max_iter','var')
    max_iter=50;
end

%X=[X,ones(size(X,1),1)];

[m,n] = size(X);

options = optimset('MaxIter', max_iter);

% Create random initial all_thetas
initial_Theta_ih = InitializeWeights(n, h);
initial_Theta_ho = InitializeWeights(h, k);

% Unroll parameters
all_thetas = [initial_Theta_ih(:) ; initial_Theta_ho(:)];

% Create "short hand" for the cost function to be minimized
costFunction = @(p) NNRegressionCost(p, ...
                           n, ...
                           h, ...
                           k, X, y, lambda);

                       
                       
[all_thetas, cost] = fmincg(costFunction, all_thetas, options);

% Obtain Theta1 and Theta2 back from nn_params
theta_ih = reshape(all_thetas(1:h * (n + 1)),h, (n + 1));

theta_ho = reshape(all_thetas((1 + (h * (n + 1))):end),k, (h + 1));

model.theta_ih = theta_ih;
model.theta_ho = theta_ho;

end