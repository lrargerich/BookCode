function p = MultivariateGaussian2(X)
X=FeatureNormalize(X,0);
p=exp(-.5*(X.^2))/(sqrt(2*pi));
p=prod(p,2);
end