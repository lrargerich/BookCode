%% X is a m x n matrix of data
%% centroids are k x n centroids
%% W is m x k matrix where Wij is the affinity
%% between point i and centroid j
function W=ComputeCentroidAffinity(X,centroids,sigma)
if ~exist('sigma','var')
  sigma=size(X,2)/3;
end
[m,n]=size(X);
[k,n]=size(centroids);
W=zeros(m,k);
for i=1:m
    for j=1:k
        W(i,j) = exp(-(sum((X(i,:)-centroids(j,:)).^2))/(sigma^2));      
    end
end
all_sum=repmat(sum(W,1),m,1);
W=W./all_sum;
end
