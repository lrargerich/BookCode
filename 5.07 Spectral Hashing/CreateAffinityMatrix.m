function W=CreateAffinityMatrix(X,sigma)
if ~exist('sigma','var')
  sigma=1
end
W=zeros(size(X,1));
for i=1:size(X,1)
    for j=i+1:size(X,1)
        W(i,j)=exp(-(norm(X(i,:)-X(j,:)))/sigma^2);
        W(j,i)=W(i,j);
    end
end
end