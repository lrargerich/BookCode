function [codes,cen,idx]=KmeansFeatures(X,k,gamma,max_iter)
if ~exist('max_iter','var')
    max_iter=100;
end
if ~exist('gamma','var')
    gamma=1;
end
codes=sparse(zeros(size(X,1),k));
addpath Kmeans/
[m,n]=size(X);
[cen,idx,dists]=Kmeans(X,k,max_iter);
codes=bsxfun(@minus,gamma*mean(dists),dists);
codes(codes<0)=0;
codes=sparse(codes);
end
