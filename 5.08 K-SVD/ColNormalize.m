function xnorm = ColNormalize(x)
    xnorm=x./repmat(sqrt(sum(x.^2,1)),size(x,1),1);
end