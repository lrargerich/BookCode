function graph=VietorisGraphBuilder(X,eps)
[m,n]=size(X);
d=squareform(pdist(X));
% Start with an empty sparse matrix
graph=sparse(m,m);
% Asociate each point with the closest k points
for i=1:size(d,1)
    [s1,s2]=sort(d(i,:));
    dists=s1;
    dists=dists(:,dists<=eps & dists>0);
    neigs=s2;
    neigs=neigs(:,dists<=eps & dists>0);
    for j=1:size(neigs,2)
        if neigs(j)~=i
            %graph(i,neigs(j))=dists(j);
            %graph(neigs(j),i)=dists(j);
            graph(i,neigs(j))=1;
            graph(neigs(j),i)=1;
        end
    end
end
end
