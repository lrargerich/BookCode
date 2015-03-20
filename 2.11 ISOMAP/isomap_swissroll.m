graph = CreateDistanceMatrix(maniX,8);
D = FloydWarshall(graph);
D=full(D);
[U,S] = MDS2(D);
U2=U(:,1:2);
scatter(U2(:,1),U2(:,2),3,ColorVector);


