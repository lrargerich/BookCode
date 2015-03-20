function k = JLMinDim(n,e)
% computes the minimum number of dimensions for n points and error=e
	k = ceil((4*log(n))/(e^2/2-e^3/3));
end