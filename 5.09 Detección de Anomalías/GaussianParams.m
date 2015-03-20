function [mu,sigma2] = GaussianParams(X)
[m, n] = size(X);
mu = mean(X);
sigma2 = zeros(n, 1);
sigma2 = (1/m)*sum(bsxfun(@minus,X,mu).^2);
end