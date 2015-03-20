function model = ELMTrainRegr( X, y, hidden)
m = size(X,1);
inputs = size(X,2);
nlabels = length(unique(y));
targets = y;
% generate random input weight matrix
inW = rand( hidden, inputs ) * 2 - 1;
% generate random hidden neuron vector
bias = rand( hidden, 1 );
% compute the pre-H matrix
preH = inW * X';
% build the bias matrix
biasM = repmat(bias,1,m);
% update the H matrix
preH = preH + biasM;
% Apply Sigmoid function
H = 1 ./ (1 + exp(-preH));
% compute weights from hidden to output (two alternatives!)
outW = pinv(H') * targets;
%C=1;
%outW = ( eye(hidden)/C + H * H') \ H * targets;
% output for the training data
scores = (H' * outW)';
model.inW=inW;
model.bias=bias;
model.outW=outW;
model.scores=scores;
end