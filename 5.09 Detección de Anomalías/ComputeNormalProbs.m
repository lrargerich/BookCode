function probs=ComputeNormalProbs(X)
  [m,n]=size(X);
  mu = mean(X);
  sigma = std(X);
  probs = bsxfun(@minus,X,mu);
  siggy = repmat(2*(sigma.^2),m,1);
  probs = exp(-probs./siggy);
  a=1./(sigma*sqrt(2*pi));
  probs = bsxfun(@times,a,probs);
end