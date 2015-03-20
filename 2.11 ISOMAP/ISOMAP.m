function Y=ISOMAP(X,dims,k)
graph = CreateDistanceMatrix(X,k);
D = FloydWarshall(graph);
D=full(D);
[U,S] = MDS2(D);
Y=U(:,1:dims);
end
