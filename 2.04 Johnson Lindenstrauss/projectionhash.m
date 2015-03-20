function xp = JLProjectionHash(X,e)
% Projection of matrix X with error e using the hashing trick
    k = mindim(size(X,1),e);
	[n,d] = size(X);
	hs = floor(d*k/3);
	xp = zeros(d,k);
	size(xp)
	for i = 1:hs
			j = 1 + floor(rand*d);
			x = 1 + floor(rand*k);
			sign = rand;
			if sign>0.5
				val = 1;
			else
				val = -1;
			end
			xp(j,x) = xp(j,x) + val;
    end
    xp = sqrt(3) * xp;
    xp = xp./sqrt(k);
end	