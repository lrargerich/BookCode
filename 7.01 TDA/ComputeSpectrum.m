function [v,lambdas]=ComputeSpectrum(x,sigma,laplacian)
if ~exist('laplacian','var'), 
    laplacian=1; 
end

W=ComputeW(x,sigma);
L=ComputeLaplacian(W,laplacian);
[v,lambdas]=eig(L);
lambdas=diag(lambdas);
[lambdas,lambdas_order]=sort(lambdas);
v=v(lambdas_order,:);
end

