function [theta, J_history,theta_history] = CD(X, y, CostFunction, num_iters,theta)
if ~exist('theta', 'var') 
    theta=rand(size(X,2)+1,1);
end
if ~exist('num_iters', 'var') 
    num_iters=100;
end
X=[ones(size(X,1),1),X];
J_history=[];
theta_history=[];
% pick a random permutation of dims
vec_dims=randperm(size(X,2));
for i=1:num_iters
    for j=1:size(X,2)
        theta = CDMaxDescent(X,y,theta,vec_dims(j),CostFunction);
        cost=CostFunction(X,y,theta);
        J_history=[J_history;cost];
        theta_history=[theta_history;theta'];
    end
    fprintf('Iteration:%d cost:%f theta0:%f theta1:%f\n',i,cost,theta(1),theta(2));
end