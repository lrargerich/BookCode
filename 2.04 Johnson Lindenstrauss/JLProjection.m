function xp = JLProjection(X,e)
% Projection of matrix X with error e
    k = JLMinDim(size(X,1),e);
	[n,d] = size(X);
	xp = normrnd(0,1/sqrt(k),d,k);
end	
