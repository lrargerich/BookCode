function [X] = FeatureUnNormalize(X,mu,varx,denoise)
	m = size(X,1);
	X=X.*repmat(sqrt(varx+denoise),m,1);
	X=X+repmat(mu,m,1);
end