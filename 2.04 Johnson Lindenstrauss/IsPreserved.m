function IsPreserved(X,A,e)
	[n,d] = size(X);
	k = size(A,1);
	for i = 1:n
		for j = (i+1):n
			u = X(i,:);
			v = X(j,:);
			d_old = norm(u-v)^2;
			d_new = norm(u*A - v*A)^2;
			fprintf('Considering pair: %d - %d\n',i,j)
			fprintf('Old: %f\n',d_old)
			fprintf('New: %f\n',d_new)
			fprintf('Within bounds %f <= %f <= %f\n',(1-e)*d_old,d_new,(1+e)*d_old)
		end
	end
end
