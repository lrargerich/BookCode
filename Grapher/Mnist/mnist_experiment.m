mnist1=mnist_train_data(mnist_train_labels==8,:);
[u,s,v]=svds(mnist1,2);
scatter(u(:,1),u(:,2),20);
