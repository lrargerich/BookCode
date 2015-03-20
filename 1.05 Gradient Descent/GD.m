function [theta, J_history,theta_history] = GD(X, y, alpha, num_iters,ComputeCost,ComputeGradient,theta)
if ~exist('theta', 'var') 
    theta=rand(size(X,2)+1,1);
end
X=[ones(size(X,1),1),X];
J_history = [];
theta_history = [];
for iter = 1:num_iters
    gradient = ComputeGradient(X,y,theta);
    %alpha = LineSearch(X,y,theta,gradient);
    theta = theta - alpha * gradient;
    cost = ComputeCost(X,y,theta);
    J_history = [J_history;cost];
    theta_history=[theta_history;theta'];
    fprintf('Iteration %d cost %f\n',iter,cost);
end
end
