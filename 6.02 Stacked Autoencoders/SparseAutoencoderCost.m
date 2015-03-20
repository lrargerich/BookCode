function [cost,grad] = LinearAutoencoderCost(theta, n, h, ...
lambda, rho, beta, X)
 
theta_ih = reshape(theta(1:h*n), h, n);
theta_ho = reshape(theta(h*n+1:2*h*n), n, h);
b_ih = theta(2*h*n+1:2*h*n+h);
b_ho = theta(2*h*n+h+1:end);
 
cost = 0;
theta_ih_grad = zeros(size(theta_ih)); 
theta_ho_grad = zeros(size(theta_ho));
b_ih_grad = zeros(size(b_ih)); 
b_ho_grad = zeros(size(b_ho));
 
[n, m] = size(X);

% Forward Propagation
H = bsxfun(@plus, theta_ih * X, b_ih);
H = Sigmoid(H);
O = bsxfun(@plus, theta_ho * H, b_ho);
O = Sigmoid(O);


errtp = ((O - X) .^ 2) ./ 2;
err = sum(sum(errtp)) ./ m;
% calculate phat average activation of hidden units
phat = sum(H, 2) ./ m;
% regularization
err2 = sum(sum(theta_ih .^ 2)) + sum(sum(theta_ho .^ 2));
err2 = err2 * lambda / 2;
% sparsity penalty
err3 = zeros(h, 1);
err3 = err3 + rho .* log(rho ./ phat) + (1 - rho) .* log((1 - rho) ./ (1 - phat));
cost = err + err2 + beta * sum(err3);
% now the gradient
delta3 = -(X - O) .* SigmoidGradient(O);
delta2 = bsxfun(@plus, (theta_ho' * delta3), beta .* (-rho ./ phat + (1 - rho) ./ (1 - phat))); 
delta2 = delta2 .* SigmoidGradient(H);
nabla_theta_ih = delta2 * X';
nabla_b_ih = delta2;
nabla_theta_ho = delta3 * H';
nabla_b_ho = delta3;
 
theta_ih_grad = nabla_theta_ih ./ m + lambda .* theta_ih;
theta_ho_grad = nabla_theta_ho ./ m + lambda .* theta_ho;
b_ih_grad = sum(nabla_b_ih, 2) ./ m;
b_ho_grad = sum(nabla_b_ho, 2) ./ m;

 
grad = [theta_ih_grad(:) ; theta_ho_grad(:) ; b_ih_grad(:) ; b_ho_grad(:)];
 
end
 

