%% Train a neural network with 1 hidden layer of h units
%% X is an mxn matrix (normalize it please!)
%% y is a labels vector
%% h is the number of hidden units
%% lambda is our beloved regularization parameter
% MINIBATCH version indicate batch size in "batch"
function [model,j_cost] = NNMBTrain(batch,X,y,h,k,lambda,alpha,max_iter)
if ~exist('max_iter','var')
    max_iter=50;
end

%X=[X,ones(size(X,1),1)];

[m,n] = size(X);

% Create random initial all_thetas
initial_Theta_ih = InitializeWeights(n, h);
initial_Theta_ho = InitializeWeights(h, k);

% Unroll parameters
all_thetas = [initial_Theta_ih(:) ; initial_Theta_ho(:)];

% Create "short hand" for the cost function to be minimized
j_cost=[];
for i=1:max_iter
    for j=1:(ceil(m/batch))
        from_record = 1+((j-1)*batch);
        to_record = from_record+batch-1;
        if to_record >m
            to_record=m;
        end
        data = X(from_record:to_record,:);

        [cost grad] = NNCost(all_thetas,n,h,k, data, y(from_record:to_record), lambda);

        all_thetas = all_thetas-alpha*grad ;
        
        % Obtain Theta1 and Theta2 back from nn_params
        theta_ih = reshape(all_thetas(1:h * (n + 1)),h, (n + 1));
        theta_ho = reshape(all_thetas((1 + (h * (n + 1))):end),k, (h + 1));
        model.theta_ih = theta_ih;
        model.theta_ho = theta_ho;
        % Remove this line if you are not debugging!
        current_prediction_level = mean(double(NNPredict(model, X) == y))* 100;
        fprintf('Epoch %4i/%4i From:%d To:%d (of %d) Cost: %4.6e | Pred.level: %4.3e\n',i,max_iter,from_record,to_record,m,cost,current_prediction_level);
        j_cost=[j_cost;current_prediction_level];
    end
    alpha = alpha/2;
end
end