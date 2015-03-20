function X = UnWhiten(X,mu,invMat)
	X = X*invMat + repmat(mu, size(X,1),1);
end	