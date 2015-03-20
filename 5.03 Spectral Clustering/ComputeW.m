% wij = exp( (-1/(2 sigma ^2)) d(xi,xj)^2 )
function M = ComputeW(X,sigma)
	dim = size(X,1);
	M = zeros(dim);
	for i=1:dim
		for j=1:dim
			if i ~= j
				M(i,j)=  exp ((-1/(2*(sigma^2))) *(distance(X(i,:),X(j,:))^2)) ;
		end
	end
	M;
end