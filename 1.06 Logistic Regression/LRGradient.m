function grad = LRGradient(x, y,theta, lambda)
	m = length(y); 
	grad = zeros(size(theta));
	h = Sigmoid(x*theta); 
	reg_grad = (lambda/m) * theta;
	reg_grad(1) = 0;
	grad = ((x' * (h-y))/m) + reg_grad;
end
