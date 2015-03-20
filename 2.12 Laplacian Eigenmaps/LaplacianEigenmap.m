function Y = LaplacianEigenmap(X,dims,k,sigma)
graph=CreateLEGraph(X,k,1);
D=diag(sum(graph,1));
L=D-graph;
[V,E]=eigs(L,dims+1,'SM');
Y=V(:,1:dims);
end

