function [centroids, idx,iter] = Kmeans(X, k,max_iter,method,eps)
if ~exist('max_iter','var'), max_iter=3000; end
if ~exist('eps','var'), eps=0.00000005; end
if ~exist('method','var'), method='points'; end

% Initialize values
[m n] = size(X);
if strcmpi(method,'PCA')
    mu=mean(X);
    x2=bsxfun(@minus,X,mu);
    [u,s,v]=svd(x2);
    [s1,s2]=sort(u(:,1));
    % k2 partitions of n1 elements
    n1=ceil(size(s2,1)/k);
    k2=floor(size(s2,1)/n1);
    n2=n1*k2;
    rest=size(s2,1)-(n2);
    s21=s2(1:n2);
    s31=reshape(s21,k2,n1);
    rest=s2(n2+1:end,:);
    centroids=[];
    for i=1:k2
        centroids=[centroids;mean(X(s31(i,:),:))];
    end
    % Add the rest
    if k>k2
        centroids=[centroids;mean(X(rest,:))];
    end
elseif strcmpi(method,'points')         
    centroids = X(1+floor(rand(k,1)*m),:);
elseif strcmpi(method,'kmeans++')
    centroids = KmeansPlusPlus(X,k);
else
    centroids=(rand(k,size(X,2)) .* repmat(max(X)-min(X),k,1))+repmat(min(X),k,1);
end

idx = zeros(m, 1);

iter = 0;
error = 10;

while (error>eps) && (iter<max_iter)
    idx = findClosestCentroids(X, centroids);
    old_centroids = centroids;    
    centroids = computeCentroids(X, idx, k);
    iter = iter+1;
    error = (sum(sum(centroids-old_centroids)));
    error = abs(error);
end
fprintf('Finished in %d iterations\n',iter)
end

