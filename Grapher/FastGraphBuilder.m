function graph=FastGraphBuilder(X,k)
[m,n]=size(X);
d=squareform(pdist(X));

% Start with an empty sparse matrix
graph=sparse(m,m);
% Asociate each point with the closest k points
for i=1:size(d,1)
    [s1,s2]=sort(d(i,:));
    dists=s1(:,2:(k+1));
    neigs=s2(:,2:(k+1));
    for j=1:size(neigs,2)
        %graph(i,neigs(j))=dists(j);
        %graph(neigs(j),i)=dists(j);
        graph(i,neigs(j))=1;
        graph(neigs(j),i)=1;
    end
end
end
