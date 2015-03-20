function best_theta=CDMaxDescent(X,y,theta,dim,CostFunction)
% Out initial cost:
previous_cost = CostFunction(X,y,theta);
epsilon = 0.00001;
initial_theta=theta;
best_theta = theta;
% We try to determine direction
dir=-1;theta_i = theta;theta_i(dim) = theta_i(dim) + epsilon;
if  CostFunction(X,y,theta_i) < previous_cost
    dir = 1;
end

% This our new theta
theta = initial_theta;
theta(dim) = initial_theta(dim) + (dir * epsilon);
% This is our new theta
new_cost = CostFunction(X,y,theta);
while (new_cost<previous_cost)
    best_theta = theta;
    epsilon = epsilon * 2;
    theta = initial_theta;
    theta(dim) = initial_theta(dim) + (dir * epsilon);
    new_cost = CostFunction(X,y,theta);
end
end