function [X, mu, varx] = featureNormalize(X,denoise)
	X = double(X);
	if ~exist('denoise','var'), denoise=10; end
	mu = mean(X);
	varx = var(X);
	for j=1:size(X,1)
  		X(j,:) = ((X(j,:) - mu) ./ sqrt(varx + denoise));
	end
end
