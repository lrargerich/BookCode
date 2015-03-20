function [pred] = StackedAutoencoderPredict(theta, inputSize, h, k, netconfig, X)
X=X';
%% Unroll theta parameter
% We first extract the part which compute the softmax gradient
softmax_theta = reshape(theta(1:h*k), k, h);

% Extract out the "stack"
stack = params2stack(theta(h*k+1:end), netconfig);

depth = numel(stack);
z = cell(depth+1,1);
a = cell(depth+1, 1);
a{1} = X;
for layer = (1:depth)
  z{layer+1} = stack{layer}.w * a{layer} + repmat(stack{layer}.b, [1, size(a{layer},2)]);
  a{layer+1} = Sigmoid(z{layer+1});
end
[~, pred] = max(softmax_theta * a{depth+1});
end