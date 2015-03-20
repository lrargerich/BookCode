function [theta, J_history,theta_history] = GD(X, y, theta, alpha, num_iters)
J_history = [];
theta_history = [];
for iter = 1:num_iters
    gradient = ComputeGradient(X,y,theta);
    %alpha = LineSearch(X,y,theta,gradient);
    theta = theta - alpha * gradient;
    cost = ComputeCost(X,y,theta);
    J_history = [J_history;cost];
    theta_history=[theta_history;theta'];
    figure(1)
    plotData(X(:,2), y);
    hold on
    plot(X(:,2), X*theta, '-')
    pause(0.002);

end

end
