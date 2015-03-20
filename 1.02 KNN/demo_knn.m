x=[-0.8 0.4];
plotDataPoints(knn1,labels1,10)
hold on
plot(x(1),x(2),'bx','MarkerSize',10);
[n,c]=KNN(x,knn1,5,labels1);
plot(n(:,1),n(:,2),'b+','MarkerSize',4);