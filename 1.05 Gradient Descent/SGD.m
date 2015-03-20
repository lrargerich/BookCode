function [theta, J_history,theta_history] = SGD(X, y, alpha, num_iters,ComputeCost,ComputeGradient,theta)
if ~exist('theta', 'var') 
    theta=rand(size(X,2)+1,1);
end
X=[ones(size(X,1),1),X];
m = length(y);  
J_history = [];
theta_history = [];
for iter = 1:num_iters
  
  for i = 1:size(X,1)
    row = X(i,:);
    gradient = ComputeGradient(row,y(i,:),theta);
    theta = theta - alpha*gradient;
	cost = ComputeCost(X, y, theta);
    J_history = [J_history;cost];
    theta_history=[theta_history;theta'];
  end
  fprintf('Iter:%d Cost:%cost\n',iter,cost);  
end
