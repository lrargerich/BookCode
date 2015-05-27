function res=SpectrumLens(X,i,sigma,method)
if ~exist('sigma','var'), 
    xx=pdist2(X,X);
    xx=median(xx(:));
    sigma = 0.1*xx;
end
if ~exist('method','var'), 
    method=1; 
end
  res=zeros(size(X,1),1);
  [v,lambdas]=ComputeSpectrum(X,sigma,method);
  res=v(:,i);
end