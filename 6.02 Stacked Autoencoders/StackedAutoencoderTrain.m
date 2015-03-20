function model = StackedAutoencoderTrain(stacked_params,n,h2,k,netconfig,lambda,X,y,max_iter)
if ~exist('max_iter','var')
    max_iter=400;
end
options.Method = 'lbfgs';
options.maxIter = max_iter;
options.display = 'on';

addpath minFunc/

[stacked_params_opt, loss] = minFunc( @(x) StackedAutoencoderCost(x, ...
      n, h2, k, netconfig, ...
      lambda,X,y), ...
      stacked_params, options);
  
 model.stacked_params=stacked_params_opt;
 model.cost=loss;
end
 