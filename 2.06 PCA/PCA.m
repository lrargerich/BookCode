function [v,e]=PCA(x,dims)

if ~exist('dims','var')
    dims = min(size(x));
end

    %y=bsxfun(@minus,x,mean(x))
    y = featureNormalize(x,0);
    y=(y'*y)*(1/size(x,1));
    [u,e,v]=svds(y,dims);
end