load('mnist_train_and_test.mat');
model=NNTrain(mnist_train_data,mnist_train_labels,25,10,1,100);
ShowImagesInGrid(model.theta_ih(:,2:end),5);
p=NNPredict(model,mnist_test_data);
sum(p==mnist_test_labels)/12000

