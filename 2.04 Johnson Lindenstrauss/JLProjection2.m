function xp = JLProjection2(X,e)
% Projection of matrix X with error e
    k = JLMinDim(size(X,1),e);
   	[n,d] = size(X);
	xp = rand(d,k);
    xp(xp>0.5) = 1;
    xp(xp<=0.5) = -1;
    xp = xp./sqrt(k);
end	