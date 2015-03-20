function [theta, J_history,theta_history] = GDLR(X, y, alpha, num_iters, lambda,theta)
J_history = [];
theta_history = [];
if ~exist('theta','var')
    theta=rand(size(X,2)+1,1);
end
if ~exist('lambda','var')
    lambda=0;
end

X=[ones(size(X,1),1),X];
for iter = 1:num_iters
    gradient = LRGradient(X,y,theta,lambda);
    %alpha = LineSearch(X,y,theta,gradient,lambda);
    theta = theta - alpha * gradient;
    cost = LRCost(X,y,theta,lambda);
    fprintf('Iteration %d cost %f\n',iter,cost);
    J_history = [J_history;cost];
    theta_history=[theta_history;theta'];
    %figure(1)
    %PlotClasses(X(:,2:end),y,theta);
    %pause(0.2);
end
end
