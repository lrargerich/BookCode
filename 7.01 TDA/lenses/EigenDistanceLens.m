function res=EigenDistanceLens(X,k)
res=zeros(size(X,1),1);
d=squareform(pdist(X));
[e,s]=eigs(d,k);
res=e(:,k);
end
    
