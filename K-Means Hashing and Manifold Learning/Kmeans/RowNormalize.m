function xnorm = RowNormalize(x)
	xnorm =x./repmat(sqrt(sum(x.^2,2)),1,size(x,2));
end