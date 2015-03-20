function scores = ELMPredict( X, model )
% number of test patterns
m = size(X,1);
% compute the pre-H matrix
preH = model.inW * X';
% build the bias matrix
biasM = repmat(model.bias,1,m);
% update the pre-H matrix
preH = preH + biasM;
% apply the activation function
H = 1 ./ (1 + exp(-preH));
% compute prediction scores
scores = (H' * model.outW)';
end