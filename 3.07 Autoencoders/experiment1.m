model=NNRegressionTrain(mnist,mnist,25,784,1,1400);
mnist_1=[ones(60000,1),mnist];
H=mnist_1*model.theta_ih';
H=Sigmoid(H);
H_1=[ones(60000,1),H];
O=H_1*model.theta_ho';
O=Sigmoid(O);
figure
ShowImagesInGrid(model.theta_ih(:,2:end),5)
figure
ShowImagesInGrid(O,5)