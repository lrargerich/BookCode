%% all_thetas is a flat version of theta_ih and theta_ho
%% n is the number of inputs (dimensions)
%% h is the number of hidden units 
%% k is the number of output units
%% X is a mxn data matrix (normalize it first please!)
%% y is a mxk matrix of labels
%% lambda is our beloved regularization parameter
function [J grad] = NNCost(all_thetas, ...
                           n, ...
                           h, ...
                           k, ...
                           X, y, lambda)
m = size(X, 1);
% We recover the two matrices from the flat versions
theta_ih = reshape(all_thetas(1:h * (n + 1)),  h, (n + 1));
theta_ho = reshape(all_thetas((1 + (h * (n + 1))):end),k, (h + 1));
% Compute hidden layer (FORWARD PROP)    
X1 = [ones(m,1) X];
H_prev = X1 * theta_ih';
H = Sigmoid(H_prev);
H = [ones(m,1),H];
% Compute Output layer
O_prev = H * theta_ho';
O = Sigmoid(O_prev);
% Extend y from a vector of labels to a matrix of mxk
if (size(y,2)<k)
    y_extended = cell2mat(arrayfun(@(x) [1:k]==x,y,'UniformOutput',false));
else
    y_extended = y;
end
% Compute cost
J = (-1/m) * sum(sum((y_extended .* log(O)) + ((1-y_extended) .* log(1-O))));
% Compute delta_o
delta_o = (O - y_extended);
% Compute delta_h
H1 = [ones(m,1) H_prev];
delta_h = (delta_o * theta_ho) .* SigmoidGradient(H1);
%% Remove first column
delta_h = delta_h(:,2:end);
% Compute gradient for theta_oh
theta_ho_grad = (delta_o' * H);
theta_ho_grad = 1/m .* theta_ho_grad;
% Compute gradient for theta_ih
theta_ih_grad = delta_h' * X1;
theta_ih_grad = 1/m .* theta_ih_grad;
% Compute regularizzation for first theta
reg_theta_ih = theta_ih .^ 2;
reg_theta_ih(:,1) = 0;
reg_theta_ih = sum(sum(reg_theta_ih));
% Compute regularization for seond theta
reg_theta_ho = theta_ho .^ 2;
reg_theta_ho(:,1) = 0;
reg_theta_ho = sum(sum(reg_theta_ho));
% Compute regularization total
regularization = (reg_theta_ih + reg_theta_ho) * (lambda/(2*m));
J = J + regularization;
% Add regularization to first gradient
regu_grad_ih = theta_ih;
regu_grad_ih(:,1) = 0;
regu_grad_ih = (lambda/m) * regu_grad_ih;
theta_ih_grad = theta_ih_grad + regu_grad_ih;
% Add regularization to second gradient
regu_grad_ho = theta_ho;
regu_grad_ho(:,1) = 0;
regu_grad_ho = (lambda/m) * regu_grad_ho;
theta_ho_grad = theta_ho_grad + regu_grad_ho;
% Unroll gradients
grad = [theta_ih_grad(:) ; theta_ho_grad(:)];
end
