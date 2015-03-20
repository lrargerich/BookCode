function grad = RegressionGradient(x, y,theta, lambda)
	m = length(y); 
	grad = zeros(size(theta));
	h = (x*theta); 
	reg_grad = (lambda/m) * theta;
	reg_grad(1) = 0;
	grad = ((x' * (h-y))/m) + reg_grad;
end
