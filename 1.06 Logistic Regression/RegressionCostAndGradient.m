function [J,grad]=RegressionCostAndGradient(theta,x,y,lambda)
    J=RegressionCost(x,y,theta,lambda);
    grad=RegressionGradient(x,y,theta,lambda);
end
