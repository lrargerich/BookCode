%% This function receives a matrix of points X mxn,
%% a vector y with targets mx1
%% a theta nx1
%% a dimension dim (between 1 and n)
%% and a cost function (must receive X,y,theta
%% and returns a new theta where we have moved in the i
%% direction as much as we could towards the minimum
function best_theta=CDMaxAscent(X,y,theta,dim,CostFunction)
best_theta = theta;
best_cost = Inf;
initial_cost = CostFunction(X,y,theta);
initial_theta=theta;
% Determine direction
epsilon = 0.00001;
alpha=epsilon;
theta_i = theta;
theta_i(dim) = theta_i(dim) + epsilon;
dir = 1;

if CostFunction(X,y,theta_i) < initial_cost
    dir = -1;
end
theta(dim) = initial_theta(dim) + (dir * alpha);
cost2 = CostFunction(X,y,theta);
previous_cost=initial_cost
while (cost2>previous_cost) 
    best_cost=cost2;
    best_theta=theta;
    previous_cost=cost2;
    alpha=alpha*2;
    theta=initial_theta;
    theta(dim) = initial_theta(dim) + (dir * alpha);
    cost2 = CostFunction(X,y,theta);
end
end