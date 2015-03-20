function D = NonLinearReducer(X,centroids,alpha)
	D = double(zeros(size(X,1),size(centroids,1)));
	for i=1:size(X,1)
		xi = X(i,:);
		d = (xi * centroids')-alpha;
		d(d<0)=0;
		D(i,:) = d;
	end
end