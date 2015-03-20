function [J] = LogisticCost(x, y, theta,lambda)
	m = length(y); % number of training examples it will be 1 for Stochastic GradientDescent
	J = 0;

    h = Sigmoid(x*theta); 
    
	reg = theta .^ 2;
	reg(1) = 0; % Don't penalize first theta'
	reg_sum = (lambda/(2*m)) * sum(reg);

	J = (sum((-y .* log(h))- ((1-y).*log(1-h))) /m) + reg_sum;
end