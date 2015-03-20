function [J] = RegressionCost(x, y, theta,lambda)
	m = length(y); % number of training examples it will be 1 for Stochastic GradientDescent
	J = 0;

    h = (x*theta); 
    
	reg = theta .^ 2;
	reg(1) = 0; % Don't penalize first theta'
	reg_sum = (lambda/(2*m)) * sum(reg);

    J = ((sum(((x*theta) - y) .^ 2)) / (2*m)) + reg_sum;
end